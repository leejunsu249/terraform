resource "aws_route_table" "ingress_public_route" {
  vpc_id = aws_vpc.ingress.id

  tags = {
    Name = "rt-${var.aws_shot_region}-${var.environment}-ingress-pub",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route_table" "ingress_private_route" {
  vpc_id = aws_vpc.ingress.id

  tags = {
    Name = "rt-${var.aws_shot_region}-${var.environment}-ingress-pri",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route_table" "egress_public_route" {
  vpc_id = aws_vpc.egress.id

  tags = {
    Name = "rt-${var.aws_shot_region}-${var.environment}-egress-pub",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route_table" "egress_private_route_1" {
  vpc_id = aws_vpc.egress.id

  tags = {
    Name = "rt-${var.aws_shot_region}-${var.environment}-egress-pri-1",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route_table" "egress_private_route_2" {
  vpc_id = aws_vpc.egress.id

  tags = {
    Name = "rt-${var.aws_shot_region}-${var.environment}-egress-pri-2",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route_table" "inspection_private_nfw_route_1" {
  vpc_id = aws_vpc.inspection.id

  tags = {
    Name = "rt-${var.aws_shot_region}-${var.environment}-inspection-pri-nfw-1",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route_table" "inspection_private_nfw_route_2" {
  vpc_id = aws_vpc.inspection.id

  tags = {
    Name = "rt-${var.aws_shot_region}-${var.environment}-inspection-pri-nfw-2",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route_table" "inspection_private_route_1" {
  vpc_id = aws_vpc.inspection.id

  tags = {
    Name = "rt-${var.aws_shot_region}-${var.environment}-inspection-pri-1",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route_table" "inspection_private_route_2" {
  vpc_id = aws_vpc.inspection.id

  tags = {
    Name = "rt-${var.aws_shot_region}-${var.environment}-inspection-pri-2",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route" "ingress_public_igw_rule" {
  route_table_id = aws_route_table.ingress_public_route.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id  = aws_internet_gateway.ingress.id
}

resource "aws_route" "ingress_public_tgw_rule" {
  route_table_id = aws_route_table.ingress_public_route.id
  destination_cidr_block    = "10.0.0.0/20"
  transit_gateway_id  = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "ingress_private_tgw_rule" {
  route_table_id = aws_route_table.ingress_private_route.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "egress_public_igw_rule" {
  route_table_id = aws_route_table.egress_public_route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.egress.id
}

resource "aws_route" "egress_public_tgw_rule" {
  route_table_id = aws_route_table.egress_public_route.id
  destination_cidr_block = "10.0.0.0/20"
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "egress_private_nat_rule_1" {
  route_table_id = aws_route_table.egress_private_route_1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id  = aws_nat_gateway.nat_pubic_1.id
}

resource "aws_route" "egress_private_tgw_rule_1" {
  route_table_id = aws_route_table.egress_private_route_1.id
  destination_cidr_block = "10.0.0.0/20"
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "egress_private_nat_rule_2" {
  route_table_id = aws_route_table.egress_private_route_2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id  = aws_nat_gateway.nat_pubic_2.id
}

resource "aws_route" "egress_private_tgw_rule_2" {
  route_table_id = aws_route_table.egress_private_route_2.id
  destination_cidr_block = "10.0.0.0/20"
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "inspection_private_nfw_tgw_rule_1" {
  route_table_id = aws_route_table.inspection_private_nfw_route_1.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "inspection_private_nfw_tgw_rule_2" {
  route_table_id = aws_route_table.inspection_private_nfw_route_2.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "inspection_private_nfw_rule_1" {
  route_table_id = aws_route_table.inspection_private_route_1.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id =  element([for ss in tolist(aws_networkfirewall_firewall.nfw.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == aws_subnet.inspection_private_nfw_subnet_1.id], 0)
}

resource "aws_route" "inspection_private_nfw_rule_2" {
  route_table_id = aws_route_table.inspection_private_route_2.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id =  element([for ss in tolist(aws_networkfirewall_firewall.nfw.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == aws_subnet.inspection_private_nfw_subnet_2.id], 0)
}

resource "aws_route_table_association" "ingress_public_subnet_1_association" {
  subnet_id = aws_subnet.ingress_public_subnet_1.id
  route_table_id = aws_route_table.ingress_public_route.id
}

resource "aws_route_table_association" "ingress_public_subnet_2_association" {
  subnet_id = aws_subnet.ingress_public_subnet_2.id
  route_table_id = aws_route_table.ingress_public_route.id
}

resource "aws_route_table_association" "ingress_private_lb_subnet_1_association" {
  subnet_id = aws_subnet.ingress_private_lb_subnet_1.id
  route_table_id = aws_route_table.ingress_private_route.id
}

resource "aws_route_table_association" "ingress_private_lb_subnet_2_association" {
  subnet_id = aws_subnet.ingress_private_lb_subnet_2.id
  route_table_id = aws_route_table.ingress_private_route.id
}

resource "aws_route_table_association" "ingress_private_app_subnet_1_association" {
  subnet_id = aws_subnet.ingress_private_app_subnet_1.id
  route_table_id = aws_route_table.ingress_private_route.id
}

resource "aws_route_table_association" "ingress_private_app_subnet_2_association" {
  subnet_id = aws_subnet.ingress_private_app_subnet_2.id
  route_table_id = aws_route_table.ingress_private_route.id
}

resource "aws_route_table_association" "ingress_private_inner_subnet_1_association" {
  subnet_id = aws_subnet.ingress_private_inner_subnet_1.id
  route_table_id = aws_route_table.ingress_private_route.id
}

resource "aws_route_table_association" "ingress_private_inner_subnet_2_association" {
  subnet_id = aws_subnet.ingress_private_inner_subnet_2.id
  route_table_id = aws_route_table.ingress_private_route.id
}

resource "aws_route_table_association" "egress_public_subnet_1_association" {
  subnet_id = aws_subnet.egress_public_subnet_1.id
  route_table_id = aws_route_table.egress_public_route.id
}

resource "aws_route_table_association" "egress_public_subnet_2_association" {
  subnet_id = aws_subnet.egress_public_subnet_2.id
  route_table_id = aws_route_table.egress_public_route.id
} 

resource "aws_route_table_association" "egress_private_inner_subnet_1_association" {
  subnet_id = aws_subnet.egress_private_inner_subnet_1.id
  route_table_id = aws_route_table.egress_private_route_1.id
}

resource "aws_route_table_association" "egress_private_inner_subnet_2_association" {
  subnet_id = aws_subnet.egress_private_inner_subnet_2.id
  route_table_id = aws_route_table.egress_private_route_2.id
} 

resource "aws_route_table_association" "inspection_private_nfw_subnet_1_association" {
  subnet_id = aws_subnet.inspection_private_nfw_subnet_1.id
  route_table_id = aws_route_table.inspection_private_nfw_route_1.id
}

resource "aws_route_table_association" "inspection_private_nfw_subnet_2_association" {
  subnet_id = aws_subnet.inspection_private_nfw_subnet_2.id
  route_table_id = aws_route_table.inspection_private_nfw_route_2.id
}

resource "aws_route_table_association" "inspection_private_inner_subnet_1_association" {
  subnet_id = aws_subnet.inspection_private_inner_subnet_1.id
  route_table_id = aws_route_table.inspection_private_route_1.id
} 

resource "aws_route_table_association" "inspection_private_inner_subnet_2_association" {
  subnet_id = aws_subnet.inspection_private_inner_subnet_2.id
  route_table_id = aws_route_table.inspection_private_route_2.id
}
