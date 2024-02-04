resource "aws_instance" "hiware" {
  ami           = var.hiware_ami
  instance_type = var.hiware_instance_type

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.id

  vpc_security_group_ids = [aws_security_group.hiware_sg.id, aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.node_subnets[0]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = file("scripts/user-data.sh")
  disable_api_termination = true
  lifecycle { ignore_changes = [user_data] }

  root_block_device {
    volume_type = "gp3"
  }

  ebs_block_device {
    device_name           = "/dev/sdf"
    delete_on_termination = true
    volume_size           = 400
    volume_type           = "gp3"
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-hiware",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-hiware",
    Hiware = "True",
    OS_info  = "CentOS_7",
    DEV_GRP  = "bmeta/management/prd",
    Protocol = "SSH_22|SFTP_22",
    Backup   = "True",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group" "hiware_sg" {
  name        = "hiware-user-sg"
  description = "Allow hiware user inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-hiware",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_hiware_inbound_tcp_8443" {
  type        = "ingress"
  from_port   = 8443
  to_port     = 8443
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "hiware-web from vpn"

  security_group_id = aws_security_group.hiware_sg.id
}

resource "aws_security_group_rule" "allow_hiware_inbound_tcp_11200" {
  type        = "ingress"
  from_port   = 11200
  to_port     = 11200
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "hireware-api from vpn"

  security_group_id = aws_security_group.hiware_sg.id
}

resource "aws_security_group_rule" "allow_hiware_inbound_tcp_14200" {
  type        = "ingress"
  from_port   = 14200
  to_port     = 14200
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "hiware-mq (noti) from vpn"

  security_group_id = aws_security_group.hiware_sg.id
}

resource "aws_security_group_rule" "allow_hiware_inbound_tcp_15300" {
  type        = "ingress"
  from_port   = 15300
  to_port     = 15300
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "hiware-rtm (streaming) from vpn"

  security_group_id = aws_security_group.hiware_sg.id
}

resource "aws_security_group_rule" "allow_hiware_inbound_tcp_1201_1209" {
  type        = "ingress"
  from_port   = 1201
  to_port     = 1209
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "psm-sys-relay (engine) from vpn"

  security_group_id = aws_security_group.hiware_sg.id
}

resource "aws_security_group_rule" "allow_hiware_inbound_tcp_5000" {
  type        = "ingress"
  from_port   = 5000
  to_port     = 5000
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "psm-sys-relay (module) from vpn"

  security_group_id = aws_security_group.hiware_sg.id
}

resource "aws_security_group_rule" "allow_hiware_inbound_tcp_7777" {
  type        = "ingress"
  from_port   = 7777
  to_port     = 7777
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "psm-gui-logger from vpn"

  security_group_id = aws_security_group.hiware_sg.id
}

resource "aws_security_group_rule" "allow_hiware_inbound_tcp_18200" {
  type        = "ingress"
  from_port   = 18200
  to_port     = 18200
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "psm-gui-logger from vpn"

  security_group_id = aws_security_group.hiware_sg.id
}

resource "aws_security_group_rule" "allow_hiware_outbound_all" {
  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.hiware_sg.id
}

resource "aws_route53_record" "private_hiware_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "hiware.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.hiware.private_ip]
}
