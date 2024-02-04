resource "aws_subnet" "egress_public_subnet_1" {

  vpc_id     = aws_vpc.egress.id
  cidr_block = var.egress_public_subnets[0]
  map_public_ip_on_launch = true
  availability_zone = var.azs[0]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-egress-pub-1-2a",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "egress_public_subnet_2" {

  vpc_id     = aws_vpc.egress.id
  cidr_block = var.egress_public_subnets[1]
  map_public_ip_on_launch = true
  availability_zone = var.azs[1]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-egress-pub-2-2c",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "egress_protected_nfw_subnet_1" {

  vpc_id     = aws_vpc.egress.id
  cidr_block = var.egress_protected_nfw_subnets[0]
  map_public_ip_on_launch = false
  availability_zone = var.azs[0]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-egress-pro-nfw-1-2a",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "egress_protected_nfw_subnet_2" {

  vpc_id     = aws_vpc.egress.id
  cidr_block = var.egress_protected_nfw_subnets[1]
  map_public_ip_on_launch = false
  availability_zone = var.azs[1]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-egress-pro-nfw-2-2c",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "egress_private_inner_subnet_1" {

  vpc_id     = aws_vpc.egress.id
  cidr_block = var.egress_private_inner_subnets[0]
  map_public_ip_on_launch = false
  availability_zone = var.azs[0]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-egress-pri-inner-1-2a",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "egress_private_inner_subnet_2" {

  vpc_id     = aws_vpc.egress.id
  cidr_block = var.egress_private_inner_subnets[1]
  map_public_ip_on_launch = false
  availability_zone = var.azs[1]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-egress-pri-inner-2-2c",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}