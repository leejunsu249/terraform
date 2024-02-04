resource "aws_security_group" "management_sg" {
  name        = "management-sg"
  description = "managament sg"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-management",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_inbound_management_ssh" {
  description       = "from hiware"
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  type              = "ingress"
  security_group_id = aws_security_group.management_sg.id
  cidr_blocks       = ["10.0.23.116/32"]
}

# resource "aws_security_group_rule" "allow_inbound_management_vpn_ssh" {
#   description       = "from vpn"
#   from_port         = 22
#   protocol          = "tcp"
#   to_port           = 22
#   type              = "ingress"
#   security_group_id = aws_security_group.management_sg.id
#   cidr_blocks       = ["192.168.1.0/24", "192.168.10.0/24"]
# }

resource "aws_security_group_rule" "allow_outbound_management" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "all from vpc"
  from_port         = 0
  protocol          = "tcp"
  to_port           = 65535
  type              = "egress"
  security_group_id = aws_security_group.management_sg.id
}
