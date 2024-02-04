resource "aws_security_group" "management_rds_sg" {
  name        = "management-rds-sg"
  description = "Allow rds management inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id
  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-management-rds",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_inbound_management_aurora" {
  description              = "ssh from dbsafer"
  from_port                = 3306
  protocol                 = "tcp"
  to_port                  = 3306
  type                     = "ingress"
  security_group_id        = aws_security_group.management_rds_sg.id
  cidr_blocks              = ["10.0.23.33/32"]
}

resource "aws_security_group_rule" "allow_gitlab_inbound_management_aurora" {
  count = var.environment == "dev" ? 1:0

  description              = "ssh from gitlab"
  from_port                = 3306
  protocol                 = "tcp"
  to_port                  = 3306
  type                     = "ingress"
  security_group_id        = aws_security_group.management_rds_sg.id
  cidr_blocks              = ["10.0.23.0/25", "10.0.23.128/25"]
}

resource "aws_security_group" "management_redis_sg" {
  name        = "management-redis-sg"
  description = "Allow redis management inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id
  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-management-redis",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_inbound_management_redis" {
  description       = "from vpn"
  from_port         = 6379
  protocol          = "tcp"
  to_port           = 6379
  type              = "ingress"
  security_group_id = aws_security_group.management_redis_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}