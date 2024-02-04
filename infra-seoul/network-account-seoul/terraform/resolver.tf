resource "aws_route53_resolver_endpoint" "resolver_inbound" {
  name      = "rslvr-an2-${var.environment}-inbound"
  direction = "INBOUND"

  security_group_ids = [
    aws_security_group.inbound_route53_resolver_sg.id
  ]

  ip_address {
    subnet_id = aws_subnet.egress_private_inner_subnet_1.id
  }

  ip_address {
    subnet_id = aws_subnet.egress_private_inner_subnet_2.id
  }

  tags = {
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_security_group" "inbound_route53_resolver_sg" {
  name        = "resolver-sg"
  description = "resolver inbound"
  vpc_id      = aws_vpc.egress.id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-resolver",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_security_group_rule" "allow_udp_hq_inbound_route53_resolver" {
  type              = "ingress"
  from_port         = 53
  to_port           = 53
  protocol          = "tcp"
  cidr_blocks       = ["192.168.1.0/24"]
  description       = "53 from hq"

  security_group_id = aws_security_group.inbound_route53_resolver_sg.id
}

resource "aws_security_group_rule" "allow_tcp_hq_inbound_route53_resolver" {
  type              = "ingress"
  from_port         = 53
  to_port           = 53
  protocol          = "udp"
  cidr_blocks       = ["192.168.1.0/24"]
  description       = "53 from hq"

  security_group_id = aws_security_group.inbound_route53_resolver_sg.id
}
