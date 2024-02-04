resource "aws_route_table" "egress_public_route_1" {
  vpc_id = aws_vpc.egress.id

  tags = {
    Name = "rt-${var.aws_shot_region}-${var.environment}-egress-pub-1",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route_table" "egress_public_route_2" {
  vpc_id = aws_vpc.egress.id

  tags = {
    Name = "rt-${var.aws_shot_region}-${var.environment}-egress-pub-2",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route_table" "egress_protected_nfw_route_1" {
  vpc_id = aws_vpc.egress.id

  tags = {
    Name = "rt-${var.aws_shot_region}-${var.environment}-egress-pro-nfw-1",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route_table" "egress_protected_nfw_route_2" {
  vpc_id = aws_vpc.egress.id

  tags = {
    Name = "rt-${var.aws_shot_region}-${var.environment}-egress-pro-nfw-2",
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

resource "aws_route" "egress_public_igw_rule_1" {
  route_table_id         = aws_route_table.egress_public_route_1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.egress.id
}

resource "aws_route" "egress_public_igw_rule_2" {
  route_table_id         = aws_route_table.egress_public_route_2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.egress.id
}

resource "aws_route" "egress_protected_nfw_rule_1" {
  route_table_id         = aws_route_table.egress_public_route_1.id
  destination_cidr_block = "10.0.16.0/20"
  vpc_endpoint_id        = element([for ss in tolist(aws_networkfirewall_firewall.nfw.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == aws_subnet.egress_protected_nfw_subnet_1.id], 0)
}

resource "aws_route" "egress_protected_nfw_rule_2" {
  route_table_id         = aws_route_table.egress_public_route_2.id
  destination_cidr_block = "10.0.16.0/20"
  vpc_endpoint_id        = element([for ss in tolist(aws_networkfirewall_firewall.nfw.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == aws_subnet.egress_protected_nfw_subnet_2.id], 0)
}

### wallet vpc ###
resource "aws_route" "egress_protected_nfw_rule_3" {
  route_table_id         = aws_route_table.egress_public_route_1.id
  destination_cidr_block = "10.0.32.0/22"
  vpc_endpoint_id        = element([for ss in tolist(aws_networkfirewall_firewall.nfw.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == aws_subnet.egress_protected_nfw_subnet_1.id], 0)
}

resource "aws_route" "egress_protected_nfw_rule_4" {
  route_table_id         = aws_route_table.egress_public_route_2.id
  destination_cidr_block = "10.0.32.0/22"
  vpc_endpoint_id        = element([for ss in tolist(aws_networkfirewall_firewall.nfw.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == aws_subnet.egress_protected_nfw_subnet_2.id], 0)
}
### wallet vpc end ###

resource "aws_route" "egress_protected_nfw_tgw_rule_1" {
  route_table_id         = aws_route_table.egress_protected_nfw_route_1.id
  destination_cidr_block = "10.0.16.0/20"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "egress_protected_nfw_tgw_rule_2" {
  route_table_id         = aws_route_table.egress_protected_nfw_route_2.id
  destination_cidr_block = "10.0.16.0/20"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

### wallet vpc ###
resource "aws_route" "egress_protected_nfw_tgw_rule_3" {
  route_table_id         = aws_route_table.egress_protected_nfw_route_1.id
  destination_cidr_block = "10.0.32.0/22"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "egress_protected_nfw_tgw_rule_4" {
  route_table_id         = aws_route_table.egress_protected_nfw_route_2.id
  destination_cidr_block = "10.0.32.0/22"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}
### wallet vpc end ###

resource "aws_route" "egress_protected_nfw_nat_rule_1" {
  route_table_id         = aws_route_table.egress_protected_nfw_route_1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_pubic_1.id
}

resource "aws_route" "egress_protected_nfw_nat_rule_2" {
  route_table_id         = aws_route_table.egress_protected_nfw_route_2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_pubic_2.id
}

resource "aws_route" "egress_private_tgw_rule_1" {
  route_table_id         = aws_route_table.egress_private_route_1.id
  destination_cidr_block = "10.0.16.0/20"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "egress_private_tgw_rule_2" {
  route_table_id         = aws_route_table.egress_private_route_2.id
  destination_cidr_block = "10.0.16.0/20"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

### wallet vpc ###
resource "aws_route" "egress_private_tgw_rule_3" {
  route_table_id         = aws_route_table.egress_private_route_1.id
  destination_cidr_block = "10.0.32.0/22"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "egress_private_tgw_rule_4" {
  route_table_id         = aws_route_table.egress_private_route_2.id
  destination_cidr_block = "10.0.32.0/22"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}
### wallet vpc end ###

### on-prem dns server ###
resource "aws_route" "egress_private_tgw_rule_5" {
  route_table_id         = aws_route_table.egress_private_route_1.id
  destination_cidr_block = "192.168.1.212/32"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "egress_private_tgw_rule_6" {
  route_table_id         = aws_route_table.egress_private_route_2.id
  destination_cidr_block = "192.168.1.212/32"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}
### on-prem dns server end ###


resource "aws_route" "egress_private_nfw_rule_1" {
  route_table_id         = aws_route_table.egress_private_route_1.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = element([for ss in tolist(aws_networkfirewall_firewall.nfw.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == aws_subnet.egress_protected_nfw_subnet_1.id], 0)
}

resource "aws_route" "egress_private_nfw_rule_2" {
  route_table_id         = aws_route_table.egress_private_route_2.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = element([for ss in tolist(aws_networkfirewall_firewall.nfw.firewall_status[0].sync_states) : ss.attachment[0].endpoint_id if ss.attachment[0].subnet_id == aws_subnet.egress_protected_nfw_subnet_2.id], 0)
}

resource "aws_route_table_association" "egress_public_subnet_1_association" {
  subnet_id      = aws_subnet.egress_public_subnet_1.id
  route_table_id = aws_route_table.egress_public_route_1.id
}

resource "aws_route_table_association" "egress_public_subnet_2_association" {
  subnet_id      = aws_subnet.egress_public_subnet_2.id
  route_table_id = aws_route_table.egress_public_route_2.id
}

resource "aws_route_table_association" "egress_protected_nfw_subnet_1_association" {
  subnet_id      = aws_subnet.egress_protected_nfw_subnet_1.id
  route_table_id = aws_route_table.egress_protected_nfw_route_1.id
}

resource "aws_route_table_association" "egress_protected_nfw_subnet_2_association" {
  subnet_id      = aws_subnet.egress_protected_nfw_subnet_2.id
  route_table_id = aws_route_table.egress_protected_nfw_route_2.id
}

resource "aws_route_table_association" "egress_private_inner_subnet_1_association" {
  subnet_id      = aws_subnet.egress_private_inner_subnet_1.id
  route_table_id = aws_route_table.egress_private_route_1.id
}

resource "aws_route_table_association" "egress_private_inner_subnet_2_association" {
  subnet_id      = aws_subnet.egress_private_inner_subnet_2.id
  route_table_id = aws_route_table.egress_private_route_2.id
}
