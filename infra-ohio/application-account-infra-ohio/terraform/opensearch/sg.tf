resource "aws_security_group" "opensearch" {
  name = "opensearch-sg"
  vpc_id  = data.terraform_remote_state.network.outputs.vpc_id
  description = "Control traffic from vpc"

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-opensearch",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_vpn_inbound" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["192.168.1.0/24", "192.168.10.0/24"]
  description       = "443 from vpn"

  security_group_id = aws_security_group.opensearch.id
}

resource "aws_security_group_rule" "allow_vpc_inbound" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = data.terraform_remote_state.network.outputs.monitor_cidr_blocks
  description       = "443 from vpc"

  security_group_id = aws_security_group.opensearch.id
}

resource "aws_security_group_rule" "allow_vpc_outbound" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = data.terraform_remote_state.network.outputs.monitor_cidr_blocks
  description       = "443 from vpc"

  security_group_id = aws_security_group.opensearch.id
}