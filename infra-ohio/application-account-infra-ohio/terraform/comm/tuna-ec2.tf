resource "aws_instance" "tuna" {
  ami           = var.common_ami
  instance_type = var.tuna_instance_type

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.id

  vpc_security_group_ids = [aws_security_group.tuna_sg.id, aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.app_subnets[1]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = data.template_file.userdata_tuna.rendered
  disable_api_termination = true

  root_block_device {
    volume_type = "gp3"
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 200
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-tuna",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-tuna",
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

data "template_file" "userdata_tuna" {
  template = file("scripts/user-data-tuna.sh")
  vars = {
    keypair_tuna = "${tls_private_key.tuna_private_key.public_key_openssh}"
  }
}

resource "aws_security_group" "tuna_sg" {
  name        = "tuna-sg"
  description = "Allow inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-tuna",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_tcp_inbound_tuna_server" {
  type        = "ingress"
  from_port   = 6100
  to_port     = 6100
  protocol    = "tcp"
  cidr_blocks = concat(["10.0.0.0/20", "10.0.16.0/20"], data.terraform_remote_state.network_an2.outputs.app_cidr_blocks, data.terraform_remote_state.network_an2.outputs.wallet_app_cidr_blocks)
  description = "from servers"

  security_group_id = aws_security_group.tuna_sg.id
}

resource "aws_security_group_rule" "allow_udp_inbound_tuna_server" {
  type        = "ingress"
  from_port   = 6100
  to_port     = 6100
  protocol    = "udp"
  cidr_blocks = concat(["10.0.0.0/20", "10.0.16.0/20"], data.terraform_remote_state.network_an2.outputs.app_cidr_blocks, data.terraform_remote_state.network_an2.outputs.wallet_app_cidr_blocks)
  description = "from servers"

  security_group_id = aws_security_group.tuna_sg.id
}

resource "aws_security_group_rule" "allow_tcp_inbound_tuna_eks" {
  type        = "ingress"
  from_port   = 6100
  to_port     = 6100
  protocol    = "tcp"
  cidr_blocks = data.terraform_remote_state.network.outputs.app_secondary_cidr_blocks
  description = "from eks"

  security_group_id = aws_security_group.tuna_sg.id
}

resource "aws_security_group_rule" "allow_udp_inbound_tuna_eks" {
  type        = "ingress"
  from_port   = 6100
  to_port     = 6100
  protocol    = "udp"
  cidr_blocks = data.terraform_remote_state.network.outputs.app_secondary_cidr_blocks
  description = "from eks"

  security_group_id = aws_security_group.tuna_sg.id
}

resource "aws_security_group_rule" "allow_inbound_tuna_http" {
  type        = "ingress"
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "from vpn"

  security_group_id = aws_security_group.tuna_sg.id
}

# resource "aws_security_group_rule" "allow_inbound_tuna_bastion_http" {
#   type        = "ingress"
#   from_port   = 8080
#   to_port     = 8080
#   protocol    = "tcp"
#   cidr_blocks = ["10.0.0.0/23"]
#   description = "from bastion"

#   security_group_id = aws_security_group.tuna_sg.id
# }

resource "aws_security_group_rule" "allow_outbound_tuna_all" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.tuna_sg.id
}

resource "aws_route53_record" "private_tuna_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "tuna.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.tuna.private_ip]
}
