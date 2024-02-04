resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${var.aws_shot_region}-${var.environment}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.vpc_secondary_cidrs
}

resource "aws_vpc_endpoint" "s3-gw-endpoint" {
  vpc_id          = aws_vpc.vpc.id
  service_name    = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = [aws_route_table.private_route.id]

  tags = {
    Name = "vpce-${var.aws_shot_region}-${var.environment}-s3-gw",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_flow_log" "vpc" {
  log_destination      = "arn:aws:s3:::s3-an2-shd-flow-logs/${var.environment}"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.vpc.id
  tags = {
    Name = "flow-logs-${var.aws_shot_region}-${var.environment}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

##### wallet vpc #####

resource "aws_vpc" "wallet_vpc" {
  cidr_block           = var.wallet_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${var.aws_shot_region}-${var.environment}-wallet",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "wallet_secondary_cidr" {
  vpc_id     = aws_vpc.wallet_vpc.id
  cidr_block = var.wallet_vpc_secondary_cidrs
}

resource "aws_vpc_endpoint" "wallet_s3-gw-endpoint" {
  vpc_id          = aws_vpc.wallet_vpc.id
  service_name    = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = [aws_route_table.wallet_private_route.id]

  tags = {
    Name = "vpce-${var.aws_shot_region}-${var.environment}-wallet-s3-gw",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_flow_log" "wallet_vpc" {
  log_destination      = "arn:aws:s3:::s3-an2-shd-flow-logs/${var.environment}"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.wallet_vpc.id
  tags = {
    Name = "flow-logs-${var.aws_shot_region}-${var.environment}-wallet",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
  depends_on = [
    aws_vpc.wallet_vpc
  ]
}
