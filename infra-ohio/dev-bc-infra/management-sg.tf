# resource "aws_security_group" "session_redis_sg-bc-an2" {
#   name        = "wallet-session-service-redis-sg-bc"
#   description = "Allow redis session inbound traffic"
#   vpc_id      = data.aws_vpc.an2_redis_vpc.id
#   tags = {
#     Name = "sg-${var.aws_an2_shot_region}-${var.environment}-naemo-wallet-redis-session-service-bc",
#     System                      = "common",
#     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
#     SupportPlatformOwnerPrimary = "BithumMeta",
#     OperationLevel              = "3"
#   }
#   provider = aws.an2
# }

# resource "aws_security_group_rule" "allow_inbound_session_redis-bc-an2" {
#   description       = "from vpn"
#   from_port         = 6379
#   protocol          = "tcp"
#   to_port           = 6379
#   type              = "ingress"
#   security_group_id = aws_security_group.session_redis_sg-bc-an2.id
#   cidr_blocks       = ["192.168.10.0/24"]
#   provider = aws.an2
# }

# resource "aws_security_group_rule" "allow_eks_inbound_session_redis-bc-an2" {
#   type                     = "ingress"
#   from_port                = 6379
#   to_port                  = 6379
#   protocol                 = "tcp"
#   source_security_group_id = var.an2_eks_cluster_node_sg_id
#   description              = "6379 from eks"

#   security_group_id = aws_security_group.session_redis_sg-bc-an2.id
#   provider = aws.an2
# }


resource "aws_security_group" "management_redis_sg-bc-an2" {
  name        = "wallet-management-redis-sg-bc"
  description = "Allow wallet management redis inbound traffic"
  vpc_id      = data.aws_vpc.an2_redis_vpc.id
  tags = {
    Name = "sg-${var.aws_an2_shot_region}-${var.environment}-wallet-management-redis-bc",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
  provider = aws.an2
}

resource "aws_security_group_rule" "allow_inbound_manage_redis-bc-an2" {
  description       = "from vpn"
  from_port         = 6379
  protocol          = "tcp"
  to_port           = 6379
  type              = "ingress"
  security_group_id = aws_security_group.management_redis_sg-bc-an2.id
  cidr_blocks       = ["192.168.10.0/24","172.16.1.0/24"]
  provider = aws.an2
}


resource "aws_security_group" "management_redis_sg-bc" {
  name        = "management-redis-sg-bc"
  description = "Allow redis management inbound traffic"
  vpc_id      = data.aws_vpc.redis_vpc.id
  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-management-redis-bc",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_inbound_management_redis-bc" {
  description       = "from vpn"
  from_port         = 6379
  protocol          = "tcp"
  to_port           = 6379
  type              = "ingress"
  security_group_id = aws_security_group.management_redis_sg-bc.id
  cidr_blocks       = ["192.168.1.0/24"]
}