# resource "aws_security_group" "management_redis_sg-bc" {
#   name        = "management-redis-sg-bc"
#   description = "Allow redis management inbound traffic"
#   vpc_id      = data.aws_vpc.redis_vpc.id
#   tags = {
#     Name = "sg-${var.aws_shot_region}-${var.environment}-management-redis-bc",
#     System                      = "common",
#     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
#     SupportPlatformOwnerPrimary = "BithumMeta",
#     OperationLevel              = "3"
#   }
# }

# resource "aws_security_group_rule" "allow_inbound_management_redis-bc" {
#   description       = "from vpn"
#   from_port         = 6379
#   protocol          = "tcp"
#   to_port           = 6379
#   type              = "ingress"
#   security_group_id = aws_security_group.management_redis_sg-bc.id
#   cidr_blocks       = ["192.168.1.0/24"]
# }
