resource "aws_instance" "search" {
  ami                    = var.common_ami
  instance_type          = var.search_instance_type
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.id
  vpc_security_group_ids = [aws_security_group.search_sg.id, aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.app_subnets[0]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = data.template_file.userdata_search.rendered
  disable_api_termination = true

  lifecycle { ignore_changes = [ebs_block_device, user_data] }

  root_block_device {
    volume_type = "gp3"
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 15
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-search",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }

  tags = {
    Name    = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-search"
    Hiware = "True",
    OS_info  = "AWS LINUX AMI 2",
    DEV_GRP  = "bmeta/marketplace/${var.environment}",
    Protocol = "SSH_22|SFTP_22",
    Backup   = "True",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
  depends_on = [aws_kms_key.ec2, aws_ebs_default_kms_key.ebs_kms]
}

data "template_file" "userdata_search" {
  template = file("scripts/user-data-search.sh")
  vars = {
    keypair_search = "${tls_private_key.search_private_key.public_key_openssh}"
  }
}

resource "aws_security_group" "search_sg" {
  name        = "search-sg"
  description = "Allow search engine inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-search",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_inbound_vpn_8081" {
  from_port         = 8081
  protocol          = "tcp"
  to_port           = 8081
  type              = "ingress"
  cidr_blocks       = [var.vpn_cidr]

  security_group_id = aws_security_group.search_sg.id
}

resource "aws_security_group_rule" "allow_inbound_vpn_8888" {
  from_port         = 8888
  protocol          = "tcp"
  to_port           = 8888
  type              = "ingress"
  cidr_blocks       = [var.vpn_cidr]

  security_group_id = aws_security_group.search_sg.id
}

resource "aws_security_group_rule" "allow_inbound_vpn_7000" {
  from_port         = 7000
  protocol          = "tcp"
  to_port           = 7000
  type              = "ingress"
  cidr_blocks       = [var.vpn_cidr]

  security_group_id = aws_security_group.search_sg.id
}

resource "aws_security_group_rule" "allow_inbound_vpn_7800" {
  from_port         = 7800
  protocol          = "tcp"
  to_port           = 7800
  type              = "ingress"
  cidr_blocks       = [var.vpn_cidr]

  security_group_id = aws_security_group.search_sg.id
}

resource "aws_security_group_rule" "allow_inbound_vpn_8080" {
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
  type              = "ingress"
  cidr_blocks       = [var.vpn_cidr]

  security_group_id = aws_security_group.search_sg.id
}

resource "aws_security_group_rule" "allow_outbound_search" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "all from vpc"
  from_port         = 0
  protocol          = "tcp"
  to_port           = 65535
  type              = "egress"
  security_group_id = aws_security_group.search_sg.id
}

resource "aws_security_group_rule" "allow_eks_app" {
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_secondary_cidr_blocks
  description       = "access eks application"
  from_port         = 8081
  protocol          = "tcp"
  to_port           = 8081
  type              = "ingress"
  security_group_id = aws_security_group.search_sg.id
}

## Internal service domain
resource "aws_route53_record" "private_search_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "search.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.search.private_ip]
}
