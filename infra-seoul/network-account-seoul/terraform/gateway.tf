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
  allocation_id     = aws_eip.nat_eip_1.id
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
  allocation_id     = aws_eip.nat_eip_2.id
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
  auto_accept_shared_attachments  = "enable"
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

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attach_egress" {
  subnet_ids                                      = [aws_subnet.egress_private_inner_subnet_1.id, aws_subnet.egress_private_inner_subnet_2.id]
  transit_gateway_id                              = aws_ec2_transit_gateway.tgw.id
  vpc_id                                          = aws_vpc.egress.id
  appliance_mode_support                          = "enable"
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

resource "aws_ec2_transit_gateway_route_table" "shd" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = "tgw-rt-${var.aws_shot_region}-${var.environment}-shd",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ec2_transit_gateway_route_table" "vpn" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = "tgw-rt-${var.aws_shot_region}-${var.environment}-vpn",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "egress" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_egress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress.id
}

resource "aws_ec2_transit_gateway_route" "default_prd" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_egress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.prd.id
}

resource "aws_ec2_transit_gateway_route" "default_stg" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_egress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.stg.id
}

resource "aws_ec2_transit_gateway_route" "default_dev" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_egress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.dev.id
}

resource "aws_ec2_transit_gateway_route" "default_shd" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_egress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.shd.id
}

resource "aws_ec2_transit_gateway_route" "prd_blackhole_stg" {
  destination_cidr_block         = "10.0.18.0/23"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.prd.id
}

resource "aws_ec2_transit_gateway_route" "prd_blackhole_dev" {
  destination_cidr_block         = "10.0.17.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.prd.id
}

resource "aws_ec2_transit_gateway_route" "prd_blackhole_wallet_prd" {
  destination_cidr_block         = "10.0.34.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.prd.id
}

resource "aws_ec2_transit_gateway_route" "prd_blackhole_wallet_stg" {
  destination_cidr_block         = "10.0.33.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.prd.id
}

resource "aws_ec2_transit_gateway_route" "prd_blackhole_wallet_dev" {
  destination_cidr_block         = "10.0.32.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.prd.id
}

resource "aws_ec2_transit_gateway_route" "stg_blackhole_prd" {
  destination_cidr_block         = "10.0.20.0/23"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.stg.id
}

resource "aws_ec2_transit_gateway_route" "stg_blackhole_dev" {
  destination_cidr_block         = "10.0.17.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.stg.id
}

resource "aws_ec2_transit_gateway_route" "stg_blackhole_wallet_prd" {
  destination_cidr_block         = "10.0.34.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.stg.id
}

resource "aws_ec2_transit_gateway_route" "stg_blackhole_wallet_stg" {
  destination_cidr_block         = "10.0.33.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.stg.id
}

resource "aws_ec2_transit_gateway_route" "stg_blackhole_wallet_dev" {
  destination_cidr_block         = "10.0.32.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.stg.id
}

resource "aws_ec2_transit_gateway_route" "dev_blackhole_prd" {
  destination_cidr_block         = "10.0.20.0/23"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.dev.id
}

resource "aws_ec2_transit_gateway_route" "dev_blackhole_stg" {
  destination_cidr_block         = "10.0.18.0/23"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.dev.id
}

resource "aws_ec2_transit_gateway_route" "dev_blackhole_wallet_prd" {
  destination_cidr_block         = "10.0.34.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.dev.id
}

resource "aws_ec2_transit_gateway_route" "dev_blackhole_wallet_stg" {
  destination_cidr_block         = "10.0.33.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.dev.id
}

resource "aws_ec2_transit_gateway_route" "dev_blackhole_wallet_dev" {
  destination_cidr_block         = "10.0.32.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.dev.id
}
 
### wallet ####

resource "aws_ec2_transit_gateway_route_table" "wallet_prd" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = "tgw-rt-${var.aws_shot_region}-${var.environment}-prd-wallet",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ec2_transit_gateway_route_table" "wallet_stg" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = "tgw-rt-${var.aws_shot_region}-${var.environment}-stg-wallet",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ec2_transit_gateway_route_table" "wallet_dev" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    Name = "tgw-rt-${var.aws_shot_region}-${var.environment}-dev-wallet",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ec2_transit_gateway_route" "default_wallet_prd" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_egress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_prd.id
}

resource "aws_ec2_transit_gateway_route" "default_wallet_stg" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_egress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_stg.id
}

resource "aws_ec2_transit_gateway_route" "default_wallet_dev" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_egress.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_dev.id
}

resource "aws_ec2_transit_gateway_route" "wallet_prd_blackhole_wallet_stg" {
  destination_cidr_block         = "10.0.33.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_prd.id
}

resource "aws_ec2_transit_gateway_route" "wallet_prd_blackhole_wallet_dev" {
  destination_cidr_block         = "10.0.32.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_prd.id
}

resource "aws_ec2_transit_gateway_route" "wallet_prd_blackhole_prd" {
  destination_cidr_block         = "10.0.20.0/23"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_prd.id
}

resource "aws_ec2_transit_gateway_route" "wallet_prd_blackhole_stg" {
  destination_cidr_block         = "10.0.18.0/23"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_prd.id
}

resource "aws_ec2_transit_gateway_route" "wallet_prd_blackhole_dev" {
  destination_cidr_block         = "10.0.17.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_prd.id
}

resource "aws_ec2_transit_gateway_route" "wallet_stg_blackhole_wallet_prd" {
  destination_cidr_block         = "10.0.34.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_stg.id
}

resource "aws_ec2_transit_gateway_route" "wallet_stg_blackhole_wallet_dev" {
  destination_cidr_block         = "10.0.32.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_stg.id
}

resource "aws_ec2_transit_gateway_route" "wallet_stg_blackhole_prd" {
  destination_cidr_block         = "10.0.20.0/23"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_stg.id
}

resource "aws_ec2_transit_gateway_route" "wallet_stg_blackhole_stg" {
  destination_cidr_block         = "10.0.18.0/23"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_stg.id
}

resource "aws_ec2_transit_gateway_route" "wallet_stg_blackhole_dev" {
  destination_cidr_block         = "10.0.17.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_stg.id
}

resource "aws_ec2_transit_gateway_route" "wallet_dev_blackhole_wallet_prd" {
  destination_cidr_block         = "10.0.34.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_dev.id
}

resource "aws_ec2_transit_gateway_route" "wallet_dev_blackhole_wallet_stg" {
  destination_cidr_block         = "10.0.33.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_dev.id
}

resource "aws_ec2_transit_gateway_route" "wallet_dev_blackhole_prd" {
  destination_cidr_block         = "10.0.20.0/23"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_dev.id
}

resource "aws_ec2_transit_gateway_route" "wallet_dev_blackhole_stg" {
  destination_cidr_block         = "10.0.18.0/23"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_dev.id
}

resource "aws_ec2_transit_gateway_route" "wallet_dev_blackhole_dev" {
  destination_cidr_block         = "10.0.17.0/24"
  blackhole                      = true
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.wallet_dev.id
}