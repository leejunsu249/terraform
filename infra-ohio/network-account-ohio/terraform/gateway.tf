resource "aws_internet_gateway" "ingress" {
  vpc_id = aws_vpc.ingress.id

  tags = {
    Name = "igw-${var.aws_shot_region}-${var.environment}-ingress",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_internet_gateway" "egress" {
  vpc_id = aws_vpc.egress.id

  tags = {
    Name = "igw-${var.aws_shot_region}-${var.environment}-egress",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_nat_gateway" "nat_pubic_1" {
  allocation_id = aws_eip.nat_eip_1.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.egress_public_subnet_1.id

  tags = {
    Name = "nat-${var.aws_shot_region}-${var.environment}-1",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_eip" "nat_eip_1" {
  public_ipv4_pool = "amazon"

  tags = {
    Name = "eip-${var.aws_shot_region}-${var.environment}-nat-1",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_nat_gateway" "nat_pubic_2" {
  allocation_id = aws_eip.nat_eip_2.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.egress_public_subnet_2.id

  tags = {
    Name = "nat-${var.aws_shot_region}-${var.environment}-2",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_eip" "nat_eip_2" {
  public_ipv4_pool = "amazon"

  tags = {
    Name = "eip-${var.aws_shot_region}-${var.environment}-nat-2",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ec2_transit_gateway" "tgw" {
  auto_accept_shared_attachments = "enable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = {
    Name = "tgw-${var.aws_shot_region}-${var.environment}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attach_ingress" {
  subnet_ids = [aws_subnet.ingress_private_inner_subnet_1.id, aws_subnet.ingress_private_inner_subnet_2.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id = aws_vpc.ingress.id
  transit_gateway_default_route_table_association = "false"
  transit_gateway_default_route_table_propagation = "false"

  tags = {
    Name = "tgw-attach-${var.aws_shot_region}-${var.environment}-ingress",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }

}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attach_egress" {
  subnet_ids = [aws_subnet.egress_private_inner_subnet_1.id, aws_subnet.egress_private_inner_subnet_2.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id = aws_vpc.egress.id
  transit_gateway_default_route_table_association = "false"
  transit_gateway_default_route_table_propagation = "false"

  tags = {
    Name = "tgw-attach-${var.aws_shot_region}-${var.environment}-egress",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }

}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attach_inspection" {
  subnet_ids = [aws_subnet.inspection_private_inner_subnet_1.id, aws_subnet.inspection_private_inner_subnet_2.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id = aws_vpc.inspection.id
  appliance_mode_support = "enable"
  transit_gateway_default_route_table_association = "false"
  transit_gateway_default_route_table_propagation = "false"

  tags = {
    Name = "tgw-attach-${var.aws_shot_region}-${var.environment}-inspection",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }

}

resource "aws_ec2_transit_gateway_route_table" "ingress" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = "tgw-rt-${var.aws_shot_region}-${var.environment}-ingress",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ec2_transit_gateway_route_table" "inspection" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = "tgw-rt-${var.aws_shot_region}-${var.environment}-inspection",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ec2_transit_gateway_route_table" "egress" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = "tgw-rt-${var.aws_shot_region}-${var.environment}-egress",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ec2_transit_gateway_route_table" "prd" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = "tgw-rt-${var.aws_shot_region}-${var.environment}-prd",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ec2_transit_gateway_route_table" "stg" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = "tgw-rt-${var.aws_shot_region}-${var.environment}-stg",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ec2_transit_gateway_route_table" "dev" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = "tgw-rt-${var.aws_shot_region}-${var.environment}-dev",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ec2_transit_gateway_route_table" "peer" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = "tgw-rt-${var.aws_shot_region}-${var.environment}-peer",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "inspection" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_inspection.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.inspection.id
  depends_on = [
    aws_ec2_transit_gateway_route_table.inspection,
  ]
}

resource "aws_ec2_transit_gateway_route_table_association" "ingress" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_ingress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ingress.id
  depends_on = [
    aws_ec2_transit_gateway_route_table.ingress,
  ]
}

resource "aws_ec2_transit_gateway_route_table_association" "egress" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_egress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress.id
  depends_on = [
    aws_ec2_transit_gateway_route_table.egress,
  ]
}

resource "aws_ec2_transit_gateway_route_table_propagation" "ingress" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_ingress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.inspection.id
  depends_on = [
    aws_ec2_transit_gateway_route_table.inspection,
  ]
}

resource "aws_ec2_transit_gateway_route" "default_ingress" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_inspection.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.ingress.id
  depends_on = [
    aws_ec2_transit_gateway_route_table.ingress,
  ]
}

resource "aws_ec2_transit_gateway_route" "default_inspection" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_egress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.inspection.id
  depends_on = [
    aws_ec2_transit_gateway_route_table.inspection,
  ]
}

resource "aws_ec2_transit_gateway_route" "default_egress" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_inspection.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress.id
  depends_on = [
    aws_ec2_transit_gateway_route_table.egress,
  ]
}

resource "aws_ec2_transit_gateway_route" "default_prd" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_inspection.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.prd.id
  depends_on = [
    aws_ec2_transit_gateway_route_table.prd,
  ]
}

resource "aws_ec2_transit_gateway_route" "default_stg" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_inspection.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.stg.id
  depends_on = [
    aws_ec2_transit_gateway_route_table.stg,
  ]
}

resource "aws_ec2_transit_gateway_route" "default_dev" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_inspection.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.dev.id
  depends_on = [
    aws_ec2_transit_gateway_route_table.dev,
  ]
}