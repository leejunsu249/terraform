resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${var.aws_region_shot}-${var.environment}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_vpc_endpoint" "s3-gw-endpoint" {
  vpc_id          = aws_vpc.vpc.id
  service_name    = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = [aws_route_table.private_route.id]

  tags = {
    Name = "vpce-${var.aws_region_shot}-${var.environment}-s3-gw",
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
    Name = "flow-logs-${var.aws_region_shot}-${var.environment}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_cloudtrail" "shd" {
  name                       = "trail-logs-${var.aws_region_shot}-${var.environment}"
  s3_bucket_name             = "s3-an2-shd-cloudtrail-logs"
  s3_key_prefix              = var.environment
  is_multi_region_trail      = true
  enable_log_file_validation = true
  tags = {
    Name = "trail-logs-${var.aws_region_shot}-${var.environment}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}
