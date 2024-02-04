resource "aws_instance" "sonarqube" {
  ami           = var.sonarqube_ami
  instance_type = var.sonarqube_instance_type

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.id

  vpc_security_group_ids = [aws_security_group.sonarqube_sg.id, aws_security_group.management_sg.id]

  subnet_id = data.terraform_remote_state.network.outputs.node_subnets[0]
  key_name  = aws_key_pair.sonarqube_keypair.key_name
  user_data = file("scripts/user-data.sh")
  disable_api_termination = true
  
  lifecycle { ignore_changes = [user_data, key_name] }

  root_block_device {
    tags = {
      Name = "ec2-${var.aws_shot_region}-${var.environment}-sonarqube-os",
      System                      = "common",
      BusinessOwnerPrimary        = "infra@bithumbmeta.io",
      SupportPlatformOwnerPrimary = "BithumMeta",
      OperationLevel              = "3"
    }
    volume_type = "gp3"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-sonarqube",
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

# data "template_file" "default_user_data" {
#   template = file("scripts/user-data.sh")
# }

resource "aws_security_group" "sonarqube_sg" {
  name        = "sonarqube-sg"
  description = "Allow sonarqube inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-sonarqube",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_sonarqube_inbound_http" {
  type        = "ingress"
  from_port   = 9000
  to_port     = 9000
  protocol    = "tcp"
  cidr_blocks = ["10.0.0.0/16"]
  description = "sonarqube service port"

  security_group_id = aws_security_group.sonarqube_sg.id
}

resource "aws_security_group_rule" "allow_sonarqube_inbound_vpn_http" {
  type        = "ingress"
  from_port   = 9000
  to_port     = 9000
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "from vpn"

  security_group_id = aws_security_group.sonarqube_sg.id
}

resource "aws_security_group_rule" "allow_sonarqube_outbound_https" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sonarqube_sg.id
}

resource "aws_route53_record" "private_sonarqube_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "sonarqube.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.sonarqube.private_ip]
}