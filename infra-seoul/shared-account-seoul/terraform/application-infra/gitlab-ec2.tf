resource "aws_instance" "gitlab_repository" {
  ami           = var.gitlab_repository_ami
  instance_type = var.gitlab_repository_instance_type

  iam_instance_profile = aws_iam_instance_profile.gitlab_profile.id

  vpc_security_group_ids = [aws_security_group.gitlab_sg.id, aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.node_subnets[0]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = file("scripts/user-data.sh")
  disable_api_termination = true
  lifecycle { ignore_changes = [user_data] }

  root_block_device {
    volume_type = "gp3"
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-gitlab",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }

  tags = {
    Name     = "ec2-${var.aws_shot_region}-${var.environment}-gitlab",
    Hiware = "True",
    OS_info  = "AWS LINUX AMI 2",
    DEV_GRP  = "bmeta/management/prd",
    Protocol = "SSH_22|SFTP_22",
    Backup   = "True",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group" "gitlab_sg" {
  name        = "gitlab-sg"
  description = "Allow gitlab inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-gitlab",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_runner_inbound_argo_http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/20"]
  description = "from argo in eks"

  security_group_id = aws_security_group.gitlab_sg.id
}

resource "aws_security_group_rule" "allow_runner_inbound_runner_http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = data.terraform_remote_state.network.outputs.node_cidr_blocks
  description = "from runner in eks"

  security_group_id = aws_security_group.gitlab_sg.id
}

resource "aws_security_group_rule" "allow_inbound_vpn_http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "from vpn"

  security_group_id = aws_security_group.gitlab_sg.id
}

resource "aws_security_group_rule" "allow_gitlab_outbound_all" {
  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.gitlab_sg.id
}

resource "aws_route53_record" "private_gitlab_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "gitlab.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.gitlab_repository.private_ip]
}
