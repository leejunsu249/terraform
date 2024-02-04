resource "aws_security_group" "management_rds_sg" {
  name        = "management-rds-sg"
  description = "Allow rds management inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id
  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-management-rds",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_security_group_rule" "allow_inbound_management_mariadb" {
  description       = "from dbsafer"
  from_port         = 13306
  protocol          = "tcp"
  to_port           = 13306
  type              = "ingress"
  security_group_id = aws_security_group.management_rds_sg.id
  cidr_blocks       = ["10.0.23.33/32"]
}

resource "aws_security_group_rule" "allow_inbound_management_vpn_maria" {
  description       = "from vpn"
  from_port         = 13306
  protocol          = "tcp"
  to_port           = 13306
  type              = "ingress"
  security_group_id = aws_security_group.management_rds_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}

resource "aws_security_group_rule" "allow_inbound_management_bastion_maria" {
  description       = "from bastion"
  from_port         = 13306
  protocol          = "tcp"
  to_port           = 13306
  type              = "ingress"
  security_group_id = aws_security_group.management_rds_sg.id
  cidr_blocks       = ["10.0.1.138/32"]
}

#### wallet vpc ####

resource "aws_security_group" "wallet_management_rds_sg" {
  name        = "wallet-management-rds-sg"
  description = "Allow rds wallet management inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.wallet_vpc_id
  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-wallet-management-rds",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_security_group_rule" "allow_inbound_management_aurora" {
  description       = "from dbsafer"
  from_port         = 3306
  protocol          = "tcp"
  to_port           = 3306
  type              = "ingress"
  security_group_id = aws_security_group.wallet_management_rds_sg.id
  cidr_blocks       = ["10.0.23.33/32"]
}

resource "aws_security_group_rule" "allow_inbound_management_vpn_aurora" {
  description       = "from vpn"
  from_port         = 3306
  protocol          = "tcp"
  to_port           = 3306
  type              = "ingress"
  security_group_id = aws_security_group.wallet_management_rds_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}

resource "aws_security_group_rule" "allow_inbound_management_bastion" {
  description       = "from bastion"
  from_port         = 3306
  protocol          = "tcp"
  to_port           = 3306
  type              = "ingress"
  security_group_id = aws_security_group.wallet_management_rds_sg.id
  cidr_blocks       = ["10.0.1.138/32"]
}

resource "aws_security_group_rule" "allow_gitlab_inbound_managed_feature_aurora" {
  count = var.environment == "dev" ? 1 : 0

  description       = "ssh from gitlab"
  from_port         = 3306
  protocol          = "tcp"
  to_port           = 3306
  type              = "ingress"
  security_group_id = aws_security_group.wallet_management_rds_sg.id
  cidr_blocks       = ["10.0.23.0/25", "10.0.23.128/25"]
}

resource "aws_security_group" "wallet_management_redis_sg" {
  name        = "wallet-management-redis-sg"
  description = "Allow redis management inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.wallet_vpc_id
  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-wallet-management-redis"
  }
}

resource "aws_security_group_rule" "allow_inbound_management_redis" {
  description       = "from vpn"
  from_port         = 6379
  protocol          = "tcp"
  to_port           = 6379
  type              = "ingress"
  security_group_id = aws_security_group.wallet_management_redis_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}
