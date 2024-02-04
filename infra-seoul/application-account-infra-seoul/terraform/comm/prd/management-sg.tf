resource "aws_security_group" "management_sg" {
  name        = "management-sg"
  description = "management sg"
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
#   cidr_blocks       = ["192.168.1.0/24"]
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

resource "aws_security_group_rule" "allow_outbound_tuna_udp_management" {
  cidr_blocks       = [var.tuna_ip]
  description       = "to tuna"
  from_port         = 6100
  protocol          = "udp"
  to_port           = 65535
  type              = "egress"
  security_group_id = aws_security_group.management_sg.id
}

#### wallet vpc ####
resource "aws_security_group" "wallet_management_sg" {
  name        = "wallet-management-sg"
  description = "wallet management sg"
  vpc_id      = data.terraform_remote_state.network.outputs.wallet_vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-wallet-management",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_security_group_rule" "allow_inbound_wallet_management_ssh" {
  description       = "ssh from hiware"
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
  type              = "ingress"
  security_group_id = aws_security_group.wallet_management_sg.id
  cidr_blocks       = ["10.0.23.116/32"]
}

# resource "aws_security_group_rule" "allow_inbound_wallet_management_vpn_ssh" {
#   description       = "from vpn"
#   from_port         = 22
#   protocol          = "tcp"
#   to_port           = 22
#   type              = "ingress"
#   security_group_id = aws_security_group.wallet_management_sg.id
#   cidr_blocks       = ["192.168.1.0/24", "192.168.10.0/24"]
# }

resource "aws_security_group_rule" "allow_outbound_wallet_management" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "all from vpc"
  from_port         = 0
  protocol          = "tcp"
  to_port           = 65535
  type              = "egress"
  security_group_id = aws_security_group.wallet_management_sg.id
}

resource "aws_security_group_rule" "allow_outbound_tuna_udp_wallet_management" {
  cidr_blocks       = [var.tuna_ip]
  description       = "to tuna"
  from_port         = 6100
  protocol          = "udp"
  to_port           = 65535
  type              = "egress"
  security_group_id = aws_security_group.wallet_management_sg.id
}
