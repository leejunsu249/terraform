resource "aws_instance" "dbsafer" {
  ami           = var.dbsafer_ami
  instance_type = var.dbsafer_instance_type

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.id

  vpc_security_group_ids = [aws_security_group.dbsafer_sg.id, aws_security_group.dbsafer_management_sg.id, aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.node_subnets[0]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = file("scripts/user-data.sh")
  disable_api_termination = true
  lifecycle { ignore_changes = [user_data] }

  root_block_device {
    volume_type = "gp3"
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-dbsafer",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-dbsafer",
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

resource "aws_security_group" "dbsafer_management_sg" {
  name        = "dbsafer-sg"
  description = "Allow dbsafer manager inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-dbsafer-management",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group" "dbsafer_sg" {
  name        = "dbsafer-user-sg"
  description = "Allow dbsafer user inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-dbsafer",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_dbsafer_management_inbound_tcp_3118" {
  type        = "ingress"
  from_port   = 3118
  to_port     = 3118
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "dbsafer port from vpn"

  security_group_id = aws_security_group.dbsafer_management_sg.id
}

resource "aws_security_group_rule" "allow_dbsafer_management_inbound_tcp_3306" {
  type        = "ingress"
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "dbsafer db port from vpn"

  security_group_id = aws_security_group.dbsafer_management_sg.id
}

resource "aws_security_group_rule" "allow_dbsafer_management_inbound_tcp_3443" {
  type        = "ingress"
  from_port   = 3443
  to_port     = 3443
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "web user authentication from vpn"

  security_group_id = aws_security_group.dbsafer_management_sg.id
}

resource "aws_security_group_rule" "allow_dbsafer_management_inbound_tcp_8001_8002" {
  type        = "ingress"
  from_port   = 8001
  to_port     = 8002
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "monitoring from vpn"

  security_group_id = aws_security_group.dbsafer_management_sg.id
}

resource "aws_security_group_rule" "allow_dbsafer_management_inbound_tcp_9521" {
  type        = "ingress"
  from_port   = 9521
  to_port     = 9521
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "oz report from vpn"

  security_group_id = aws_security_group.dbsafer_management_sg.id
}

resource "aws_security_group_rule" "allow_dbsafer_management_inbound_tcp_20023" {
  type        = "ingress"
  from_port   = 20023
  to_port     = 20023
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "ShellReplayer from vpn"

  security_group_id = aws_security_group.dbsafer_management_sg.id
}

resource "aws_security_group_rule" "allow_dbsafer_management_inbound_tcp_50035" {
  type        = "ingress"
  from_port   = 50035
  to_port     = 50035
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "backupfile from vpn"

  security_group_id = aws_security_group.dbsafer_management_sg.id
}

resource "aws_security_group_rule" "allow_dbsafer_tcp_3163" {
  type        = "ingress"
  from_port   = 3163
  to_port     = 3163
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "tunneling from vpn"

  security_group_id = aws_security_group.dbsafer_sg.id
}

resource "aws_security_group_rule" "allow_dbsafer_tcp_3361_3362" {
  type        = "ingress"
  from_port   = 3361
  to_port     = 3362
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "SSL port from vpn"

  security_group_id = aws_security_group.dbsafer_sg.id
}

resource "aws_security_group_rule" "allow_dbsafer_inbound_tcp_3443" {
  type        = "ingress"
  from_port   = 3443
  to_port     = 3443
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "web user authentication from vpn"

  security_group_id = aws_security_group.dbsafer_sg.id
}

resource "aws_security_group_rule" "allow_dbsafer_inbound_tcp_8000" {
  type        = "ingress"
  from_port   = 8000
  to_port     = 8000
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "validation check from vpn"

  security_group_id = aws_security_group.dbsafer_sg.id
}

resource "aws_security_group_rule" "allow_dbsafer_inbound_tcp_50011_50012" {
  type        = "ingress"
  from_port   = 50011
  to_port     = 50012
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "SSL port from vpn"

  security_group_id = aws_security_group.dbsafer_sg.id
}

resource "aws_security_group_rule" "allow_dbsafer_inbound_tcp_4000_4100" {
  type        = "ingress"
  from_port   = 4000
  to_port     = 4100
  protocol    = "tcp"
  cidr_blocks = ["192.168.1.0/24"]
  description = "DB Proxy port from vpn"

  security_group_id = aws_security_group.dbsafer_sg.id
}

resource "aws_security_group_rule" "allow_dbsafer_management_outbound_tcp_all" {
  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.dbsafer_management_sg.id
}

resource "aws_security_group_rule" "allow_dbsafer_management_outbound_udp_all" {
  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "udp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.dbsafer_management_sg.id
}

resource "aws_security_group_rule" "allow_dbsafer_outbound_tcp_all" {
  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.dbsafer_sg.id
}

resource "aws_security_group_rule" "allow_dbsafer_outbound_udp_all" {
  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "udp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.dbsafer_sg.id
}
