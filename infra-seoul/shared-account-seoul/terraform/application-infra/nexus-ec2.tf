resource "aws_instance" "nexus" {
  ami           = var.common_ami
  instance_type = var.nexus_instance_type

  iam_instance_profile = aws_iam_instance_profile.ec2_nexus_profile.id

  vpc_security_group_ids = [aws_security_group.nexus_sg.id, aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.node_subnets[1]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = file("scripts/user-data.sh")
  disable_api_termination = true
  lifecycle { ignore_changes = [user_data] }

  root_block_device {
    volume_type = "gp3"
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-nexus"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-nexus",
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

resource "aws_route53_record" "private_nexus_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "nexus.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.nexus.private_ip]
}


resource "aws_security_group" "nexus_sg" {
  name        = "nexus-sg"
  description = "nexus sg"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-nexus",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_runner_inbound_nexus_runner_http" {
  type        = "ingress"
  from_port   = 8081
  to_port     = 8081
  protocol    = "tcp"
  cidr_blocks = data.terraform_remote_state.network.outputs.node_cidr_blocks
  description = "from runner in eks"

  security_group_id = aws_security_group.nexus_sg.id
}

resource "aws_security_group_rule" "allow_inbound_nexus_vpn_http" {
  type        = "ingress"
  from_port   = 8081
  to_port     = 8081
  protocol    = "tcp"
  cidr_blocks = ["192.168.10.0/24"] # 수정 1 > 10 월렛망 변경 완료 
  description = "from vpn"

  security_group_id = aws_security_group.nexus_sg.id
}

# forti 추가 
resource "aws_security_group_rule" "allow_inbound_nexus_vpn_http_forti" {
  type        = "ingress"
  from_port   = 8081
  to_port     = 8081
  protocol    = "tcp"
  cidr_blocks = ["172.16.0.0/24"] 
  description = "from forti-ssl vpn"

  security_group_id = aws_security_group.nexus_sg.id
}

# forti wallet 추가 
resource "aws_security_group_rule" "allow_inbound_nexus_vpn_http_forti_wallet" {
  type        = "ingress"
  from_port   = 8081
  to_port     = 8081
  protocol    = "tcp"
  cidr_blocks = ["172.16.1.0/24"] 
  description = "from forti-ssl wallet vpn"

  security_group_id = aws_security_group.nexus_sg.id
}

resource "aws_security_group_rule" "allow_outbound_nexus_all" {
  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.nexus_sg.id
}
