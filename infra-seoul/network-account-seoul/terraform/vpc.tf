resource "aws_vpc" "egress" {
  cidr_block = var.vpc_cidr
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

resource "aws_vpc_endpoint" "s3_gw_endpoint_egress" {
  vpc_id       = aws_vpc.egress.id
  service_name = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = [aws_route_table.egress_public_route_1.id, aws_route_table.egress_public_route_2.id, aws_route_table.egress_protected_nfw_route_1.id, aws_route_table.egress_protected_nfw_route_2.id, aws_route_table.egress_private_route_1.id, aws_route_table.egress_private_route_2.id]
  
  tags = {
    Name = "vpce-${var.aws_shot_region}-${var.environment}-s3-gw-egress",
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