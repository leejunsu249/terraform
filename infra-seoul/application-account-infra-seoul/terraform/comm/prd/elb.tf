### ALB

resource "aws_lb" "alb" {
  name                   = "alb-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs"
  internal               = true
  load_balancer_type     = "application"
  security_groups        = [aws_security_group.bcs_alb_sg.id]
  subnets                = data.terraform_remote_state.network.outputs.lb_subnets
  desync_mitigation_mode = "defensive"
  enable_cross_zone_load_balancing = true

  enable_deletion_protection = true

  access_logs {
    bucket  = "s3-an2-shd-alb-logs"
    prefix  = "prd"
    enabled = true
  }

  tags = {
    Name = "alb-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs"
  }
}

resource "aws_lb_listener" "http_18080" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "18080"
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "error"
      status_code  = "503"
    }
  }
}

resource "aws_lb_listener_rule" "monarest_18080" {
  listener_arn = aws_lb_listener.http_18080.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http_monarest_18080.arn
  }

  condition {
    host_header {
      values = ["mona-rest.mgmt.an2.prd.naemo.io"]
    }
  }
}

resource "aws_lb_target_group" "http_monarest_18080" {
  name     = "tg-http-${var.environment}-bcs-monarest-18080"
  port     = "18080"
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.network.outputs.vpc_id

  health_check {
    path = "/blockheight/get?profileName=bm1user3"
  }

  tags = {
    Name = "tg-http-${var.environment}-bcs-monarest-18080",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_lb_target_group_attachment" "monarest_18080" {
  count            = length(aws_instance.monarest)
  target_group_arn = aws_lb_target_group.http_monarest_18080.arn
  target_id        = aws_instance.monarest[count.index].id
  port             = 18080
}

resource "aws_route53_record" "private_monarest_elb_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "mona-rest.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

### ALB security group

resource "aws_security_group" "bcs_alb_sg" {
  name        = "bcs-alb-sg"
  description = "Allow bcs inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-bcs-alb",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_security_group_rule" "allow_inbound_alb_18080" {
  description       = "from vpn"
  from_port         = 18080
  protocol          = "tcp"
  to_port           = 18080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_alb_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}

resource "aws_security_group_rule" "allow_inbound_alb_18080_middleware" {
  description       = "from middleware"
  from_port         = 18080
  protocol          = "tcp"
  to_port           = 18080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_alb_sg.id
  cidr_blocks       = data.terraform_remote_state.network_ue2.outputs.app_cidr_blocks
}

# need to terraform import
# terraform import -var-file configurations/prd.tfvars aws_security_group_rule.allow_inbound_alb_18080_vpnn sg-0a7bf3fafb6948db1_ingress_tcp_18080_18080_172.16.0.0/24
resource "aws_security_group_rule" "allow_inbound_alb_18080_vpnn" {
  description       = "from forti-ssl vpn"
  from_port         = 18080
  protocol          = "tcp"
  to_port           = 18080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_alb_sg.id
  cidr_blocks       = ["172.16.0.0/24"]
}

resource "aws_security_group_rule" "allow_outbound_alb" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "all from vpc"
  from_port         = 0
  protocol          = "tcp"
  to_port           = 65535
  type              = "egress"
  security_group_id = aws_security_group.bcs_alb_sg.id
}

### NLB - WALLET VPC ####

resource "aws_lb" "nlb" {
  name               = "nlb-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}"
  internal           = true
  load_balancer_type = "network"
  subnets            = data.terraform_remote_state.network.outputs.wallet_lb_subnets

  enable_deletion_protection       = true
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "nlb-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}",
    System                      = "centralwallet",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_lb_listener" "tcp_8080" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "8080"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tcp_kms_8080.arn
  }
}

resource "aws_lb_listener" "tcp_8443" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "8443"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tcp_kms_8443.arn
  }
}

resource "aws_lb_target_group" "tcp_kms_8080" {
  name     = "tg-http-${var.environment}-wallet-kms-8080"
  port     = "8080"
  protocol = "TCP"
  vpc_id   = data.terraform_remote_state.network.outputs.wallet_vpc_id

  tags = {
    Name = "tg-tcp-${var.environment}-wallet-kms-8080",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_lb_target_group" "tcp_kms_8443" {
  name     = "tg-http-${var.environment}-wallet-kms-8443"
  port     = "8443"
  protocol = "TCP"
  vpc_id   = data.terraform_remote_state.network.outputs.wallet_vpc_id
  deregistration_delay = 60

  health_check {
    protocol = "tcp"
    interval = 5
    timeout  = 5
  }

  tags = {
    Name = "tg-tcp-${var.environment}-bcs-wallet-8443",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_lb_target_group_attachment" "kms_8080" {
  count            = length(aws_instance.kms)
  target_group_arn = aws_lb_target_group.tcp_kms_8080.arn
  target_id        = aws_instance.kms[count.index].id
  port             = 8080
}

resource "aws_lb_target_group_attachment" "kms_8443" {
  count            = length(aws_instance.kms)
  target_group_arn = aws_lb_target_group.tcp_kms_8443.arn
  target_id        = aws_instance.kms[count.index].id
  port             = 8443
}

resource "aws_route53_record" "private_kms_elb_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "kms.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.nlb.dns_name
    zone_id                = aws_lb.nlb.zone_id
    evaluate_target_health = true
  }
}

