resource "aws_subnet" "ingress_public_subnet_1" {

  vpc_id     = aws_vpc.ingress.id
  cidr_block = var.ingress_public_subnets[0]
  map_public_ip_on_launch = true
  availability_zone = var.azs[0]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-ingress-pub-1-2a",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "ingress_public_subnet_2" {

  vpc_id     = aws_vpc.ingress.id
  cidr_block = var.ingress_public_subnets[1]
  map_public_ip_on_launch = true
  availability_zone = var.azs[1]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-ingress-pub-2-2b",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "ingress_private_lb_subnet_1" {

  vpc_id     = aws_vpc.ingress.id
  cidr_block = var.ingress_private_lb_subnets[0]
  map_public_ip_on_launch = false
  availability_zone = var.azs[0]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-ingress-pri-lb-1-2a",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "ingress_private_lb_subnet_2" {

  vpc_id     = aws_vpc.ingress.id
  cidr_block = var.ingress_private_lb_subnets[1]
  map_public_ip_on_launch = false
  availability_zone = var.azs[1]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-ingress-pri-lb-2-2b",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "ingress_private_app_subnet_1" {

  vpc_id     = aws_vpc.ingress.id
  cidr_block = var.ingress_private_app_subnets[0]
  map_public_ip_on_launch = false
  availability_zone = var.azs[0]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-ingress-pri-app-1-2a",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "ingress_private_app_subnet_2" {

  vpc_id     = aws_vpc.ingress.id
  cidr_block = var.ingress_private_app_subnets[1]
  map_public_ip_on_launch = false
  availability_zone = var.azs[1]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-ingress-pri-app-2-2b",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "ingress_private_inner_subnet_1" {
 
  vpc_id     = aws_vpc.ingress.id
  cidr_block = var.ingress_private_inner_subnets[0]
  map_public_ip_on_launch = false
  availability_zone = var.azs[0]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-ingress-pri-inner-1-2a",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "ingress_private_inner_subnet_2" {

  vpc_id     = aws_vpc.ingress.id
  cidr_block = var.ingress_private_inner_subnets[1]
  map_public_ip_on_launch = false
  availability_zone = var.azs[1]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-ingress-pri-inner-2-2b",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

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
    Name = "sbn-${var.aws_shot_region}-${var.environment}-egress-pub-2-2b",
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
    Name = "sbn-${var.aws_shot_region}-${var.environment}-egress-pri-inner-2-2b",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "inspection_private_nfw_subnet_1" {

  vpc_id     = aws_vpc.inspection.id
  cidr_block = var.inspection_private_nfw_subnets[0]
  map_public_ip_on_launch = false
  availability_zone = var.azs[0]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-inspection-pri-nfw-1-2a",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "inspection_private_nfw_subnet_2" {

  vpc_id     = aws_vpc.inspection.id
  cidr_block = var.inspection_private_nfw_subnets[1]
  map_public_ip_on_launch = false
  availability_zone = var.azs[1]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-inspection-pri-nfw-2-2b",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "inspection_private_inner_subnet_1" {
 
  vpc_id     = aws_vpc.inspection.id
  cidr_block = var.inspection_private_inner_subnets[0]
  map_public_ip_on_launch = false
  availability_zone = var.azs[0]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-inspection-pri-inner-1-2a",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "inspection_private_inner_subnet_2" {

  vpc_id     = aws_vpc.inspection.id
  cidr_block = var.inspection_private_inner_subnets[1]
  map_public_ip_on_launch = false
  availability_zone = var.azs[1]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-inspection-pri-inner-2-2b",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}