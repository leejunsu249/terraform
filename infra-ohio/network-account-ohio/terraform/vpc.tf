resource "aws_vpc" "ingress" {
  cidr_block = var.vpc_cidr[0]
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${var.aws_shot_region}-${var.environment}-ingress",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_vpc" "egress" {
  cidr_block = var.vpc_cidr[1]
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${var.aws_shot_region}-${var.environment}-egress",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}


resource "aws_vpc" "inspection" {
  cidr_block = var.vpc_cidr[2]
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${var.aws_shot_region}-${var.environment}-inspection",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_vpc_endpoint" "s3-gw-endpoint-ingress" {
  vpc_id       = aws_vpc.ingress.id
  service_name = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = [aws_route_table.ingress_public_route.id, aws_route_table.ingress_private_route.id]
  
  tags = {
    Name = "vpce-${var.aws_shot_region}-${var.environment}-s3-gw-ingress",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_vpc_endpoint" "s3-gw-endpoint-egress" {
  vpc_id       = aws_vpc.egress.id
  service_name = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = [aws_route_table.egress_public_route.id, aws_route_table.egress_private_route_1.id, aws_route_table.egress_private_route_2.id]
  
  tags = {
    Name = "vpce-${var.aws_shot_region}-${var.environment}-s3-gw-egress",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_vpc_endpoint" "s3-gw-endpoint-inspection" {
  vpc_id       = aws_vpc.inspection.id
  service_name = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = [aws_route_table.inspection_private_nfw_route_1.id, aws_route_table.inspection_private_nfw_route_2.id,
    aws_route_table.inspection_private_route_1.id, aws_route_table.inspection_private_route_2.id]
  
  tags = {
    Name = "vpce-${var.aws_shot_region}-${var.environment}-s3-gw-inspection",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_flow_log" "ingress" {
  log_destination      = "arn:aws:s3:::s3-an2-shd-flow-logs/${var.environment}"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.ingress.id
  tags                 = {
    Name = "flow-logs-${var.aws_shot_region}-${var.environment}-ingress",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_flow_log" "egress" {
  log_destination      = "arn:aws:s3:::s3-an2-shd-flow-logs/${var.environment}"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.egress.id
  tags                 = {
    Name = "flow-logs-${var.aws_shot_region}-${var.environment}-egress",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_flow_log" "inspection" {
  log_destination      = "arn:aws:s3:::s3-an2-shd-flow-logs/${var.environment}"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.inspection.id
  tags                 = {
    Name = "flow-logs-${var.aws_shot_region}-${var.environment}-inspection",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_cloudtrail" "net" {
  name                          = "trail-logs-${var.aws_shot_region}-${var.environment}"
  s3_bucket_name                = "s3-an2-shd-cloudtrail-logs"
  s3_key_prefix                 = "${var.environment}"
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  tags                 = {
    Name = "trail-logs-${var.aws_shot_region}-${var.environment}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}