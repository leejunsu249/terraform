## ALB KMS 
resource "aws_lb" "kms_alb" {
  count              = var.environment == "dev" ? 0 : 1
  name               = "alb-${var.aws_shot_region}-${var.environment}-naemo-kms"
  internal           = true
  enable_deletion_protection       = true 
  enable_cross_zone_load_balancing = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_lb_kms[0].id]
  subnets            = [data.terraform_remote_state.network.outputs.wallet_lb_subnets[0],data.terraform_remote_state.network.outputs.wallet_lb_subnets[1]]



  access_logs {
    bucket  = "s3-an2-shd-alb-logs"
    prefix  = "prd"
    enabled = var.environment == "dev" ? false : (var.environment == "stg" ? false : true )
  }

  tags = {
    Name = "alb-${var.aws_shot_region}-${var.environment}-naemo-bcs-kms",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
  depends_on = [ 
    aws_security_group.allow_lb_kms[0]
   ]

}

# # KMS ALB Listener 등록
resource "aws_lb_listener" "http_8080" {
  count             = var.environment == "dev" ? 0 : 1
  load_balancer_arn = aws_lb.kms_alb[0].arn
  port              = "8080"
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = "8443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https_8443" {
  count             = var.environment == "dev" ? 0 : 1
  load_balancer_arn = aws_lb.kms_alb[0].arn
  port              = "8443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.kms_acm_arn}"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http_kms_8080[0].arn
  }
  depends_on = [ 
    aws_lb_target_group.http_kms_8080[0]
   ]
}


resource "aws_lb_target_group" "http_kms_8080" {
  count              = var.environment == "dev" ? 0 : 1
  name     = "tg-https-${var.environment}-wallet-kms-8080"
  port     = "8080"
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.network.outputs.wallet_vpc_id

  health_check {
    path = "/bkms-api/healthcheck"
    port = "8080"
    protocol = "HTTP"
  }

  tags = {
    Name = "tg-tcp-${var.environment}-wallet-kms-8080",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

### listenner Rule ###
resource "aws_lb_listener_rule" "kms_rule" {
  count        = var.environment == "dev" ? 0 : 1
  listener_arn = aws_lb_listener.https_8443[0].arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http_kms_8080[0].arn
  }

  # condition {
  #   path_pattern {
  #     values = ["/bkms-api/healthcheck"]
  #   }
  # }

  condition {
    host_header {
      values = ["kms.mgmt.an2.dev.naemo.io"]
    }
  }
}


resource "aws_lb_target_group_attachment" "kms_8080" {
  count              = var.environment == "dev" ? 0 : length(aws_instance.kms)
  target_group_arn = aws_lb_target_group.http_kms_8080[0].arn
  target_id        = aws_instance.kms[count.index].id
  port             = 8080
}


resource "aws_security_group" "allow_lb_kms" {
  count       = var.environment == "dev" ? 0 : 1
  name        = "kms-alb-sg"
  description = "Allow kms"
  vpc_id      = data.terraform_remote_state.network.outputs.wallet_vpc_id

  ingress {
    description      = "from bc-centralwallet"
    from_port        = 8443
    to_port          = 8443
    protocol         = "tcp"
    cidr_blocks      = ["100.64.31.0/24","100.64.30.0/24","192.168.10.0/24"]
  }
  ingress {
    description      = "from bc-centralwallet"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["100.64.31.0/24","100.64.30.0/24","192.168.10.0/24"]
  }
  egress {
    description      = "all from vpc"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    System = "kms",
    Name = "sg-${var.aws_shot_region}-${var.environment}-kms-alb",
    Environment = "${var.environment}",
    OperationLevel = "2",
    SupportPlatformOwnerPrimary = "BithumMeta",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    Terraform = "True"
  }

}