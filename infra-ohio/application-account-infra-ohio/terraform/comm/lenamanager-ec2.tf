resource "aws_instance" "lenamaneger" {
  ami           = var.common_ami
  instance_type = var.lena_instance_type

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.id

  vpc_security_group_ids = [aws_security_group.lenamaneger_sg.id, aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.app_subnets[0]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = data.template_file.userdata_lena.rendered
  disable_api_termination = true

  root_block_device {
    volume_type = "gp3"
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-lenamaneger",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-lenamaneger",
    Hiware = "True",
    OS_info  = "AWS LINUX AMI 2",
    DEV_GRP  = "bmeta/management/${var.environment}",
    Protocol = "SSH_22|SFTP_22",
    Backup   = "True",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }

  lifecycle {
    ignore_changes = [user_data, ebs_block_device, ami]
  }

  depends_on = [aws_kms_key.ec2, aws_ebs_default_kms_key.ebs_kms]
}

data "template_file" "userdata_lena" {
  template = file("scripts/user-data-lena.sh")
  vars = {
    keypair_lena = "${tls_private_key.lena_private_key.public_key_openssh}",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group" "lenamaneger_sg" {
  name        = "lenamaneger-proxy-sg"
  description = "Allow proxy inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-lenamaneger",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_web_inbound_http" {
  type        = "ingress"
  from_port   = 7700
  to_port     = 7700
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "from vpn"

  security_group_id = aws_security_group.lenamaneger_sg.id
}

resource "aws_security_group_rule" "allow_web_inbound_http_wallet" {
  type        = "ingress"
  from_port   = 7700
  to_port     = 7700
  protocol    = "tcp"
  cidr_blocks = ["192.168.10.0/24"]
  description = "from wallet vpn"

  security_group_id = aws_security_group.lenamaneger_sg.id
}

# resource "aws_security_group_rule" "allow_web_inbound_bastion_http" {
#   type        = "ingress"
#   from_port   = 7700
#   to_port     = 7700
#   protocol    = "tcp"
#   cidr_blocks = ["10.0.0.0/23"]
#   description = "from bastion"

#   security_group_id = aws_security_group.lenamaneger_sg.id
# }

resource "aws_security_group_rule" "allow_inbound_udp" {
  type        = "ingress"
  from_port   = 16100
  to_port     = 16100
  protocol    = "udp"
  cidr_blocks = data.terraform_remote_state.network.outputs.app_secondary_cidr_blocks
  description = "from eks"

  security_group_id = aws_security_group.lenamaneger_sg.id
}

resource "aws_security_group_rule" "allow_inbound_tcp" {
  type        = "ingress"
  from_port   = 16100
  to_port     = 16100
  protocol    = "tcp"
  cidr_blocks = data.terraform_remote_state.network.outputs.app_secondary_cidr_blocks
  description = "from eks"

  security_group_id = aws_security_group.lenamaneger_sg.id
}

resource "aws_security_group_rule" "forti-ssl-vpn" {
  type        = "ingress"
  from_port   = 7700
  to_port     = 7700
  protocol    = "tcp"
  cidr_blocks = ["172.16.0.0/24"]
  description = "from forti-ssl vpn"

  security_group_id = aws_security_group.lenamaneger_sg.id
}

resource "aws_security_group_rule" "forti-ssl-vpn-wallet" {
  type        = "ingress"
  from_port   = 7700
  to_port     = 7700
  protocol    = "tcp"
  cidr_blocks = ["172.16.1.0/24"]
  description = "from forti-ssl wallet vpn"

  security_group_id = aws_security_group.lenamaneger_sg.id
}

resource "aws_security_group_rule" "allow_outbound_all" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.lenamaneger_sg.id
}

resource "aws_route53_record" "private_lenamanager_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "lena.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.lenamaneger.private_ip]
}
