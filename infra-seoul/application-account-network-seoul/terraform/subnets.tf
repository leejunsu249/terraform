resource "aws_subnet" "private_inner_subnet" {
  count = length(var.private_inner_subnets) > 0 ? length(var.private_inner_subnets) : 0

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_inner_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-pri-inner-${count.index + 1}-${split("-", element(var.azs, count.index))[2]}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "private_app_subnet" {
  count = length(var.private_app_subnets) > 0 ? length(var.private_app_subnets) : 0

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_app_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-pri-app-${count.index + 1}-${split("-", element(var.azs, count.index))[2]}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "private_db_subnet" {
  count = length(var.private_db_subnets) > 0 ? length(var.private_db_subnets) : 0

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_db_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-pri-db-${count.index + 1}-${split("-", element(var.azs, count.index))[2]}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "private_lb_subnet" {
  count = length(var.private_lb_subnets) > 0 ? length(var.private_lb_subnets) : 0

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_lb_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name                              = "sbn-${var.aws_shot_region}-${var.environment}-pri-lb-${count.index + 1}-${split("-", element(var.azs, count.index))[2]}",
    "kubernetes.io/role/internal-elb" = 1,
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "private_secondary_subnet" {
  count = length(var.private_secondary_subnets) > 0 ? length(var.private_secondary_subnets) : 0

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_secondary_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.azs, count.index)

  depends_on = [
    aws_vpc_ipv4_cidr_block_association.secondary_cidr,
  ]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-pri-secondary-${count.index + 1}-${split("-", element(var.azs, count.index))[2]}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

##### wallet vpc #####

resource "aws_subnet" "wallet_private_inner_subnet" {
  count = length(var.wallet_private_inner_subnets) > 0 ? length(var.wallet_private_inner_subnets) : 0

  vpc_id                  = aws_vpc.wallet_vpc.id
  cidr_block              = element(var.wallet_private_inner_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.wallet_azs, count.index)

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-wallet-pri-inner-${count.index + 1}-${split("-", element(var.wallet_azs, count.index))[2]}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "wallet_private_app_subnet" {
  count = length(var.wallet_private_app_subnets) > 0 ? length(var.wallet_private_app_subnets) : 0

  vpc_id                  = aws_vpc.wallet_vpc.id
  cidr_block              = element(var.wallet_private_app_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.wallet_azs, count.index)

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-wallet-pri-app-${count.index + 1}-${split("-", element(var.wallet_azs, count.index))[2]}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "wallet_private_db_subnet" {
  count = length(var.wallet_private_db_subnets) > 0 ? length(var.wallet_private_db_subnets) : 0

  vpc_id                  = aws_vpc.wallet_vpc.id
  cidr_block              = element(var.wallet_private_db_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.wallet_azs, count.index)

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-wallet-pri-db-${count.index + 1}-${split("-", element(var.wallet_azs, count.index))[2]}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "wallet_private_lb_subnet" {
  count = length(var.wallet_private_lb_subnets) > 0 ? length(var.wallet_private_lb_subnets) : 0

  vpc_id                  = aws_vpc.wallet_vpc.id
  cidr_block              = element(var.wallet_private_lb_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.wallet_azs, count.index)

  tags = {
    Name                              = "sbn-${var.aws_shot_region}-${var.environment}-wallet-pri-lb-${count.index + 1}-${split("-", element(var.wallet_azs, count.index))[2]}",
    "kubernetes.io/role/internal-elb" = 1,
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_subnet" "wallet_private_secondary_subnet" {
  count = length(var.wallet_private_secondary_subnets) > 0 ? length(var.wallet_private_secondary_subnets) : 0

  vpc_id                  = aws_vpc.wallet_vpc.id
  cidr_block              = element(var.wallet_private_secondary_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.wallet_azs, count.index)

  depends_on = [
    aws_vpc_ipv4_cidr_block_association.wallet_secondary_cidr,
  ]

  tags = {
    Name = "sbn-${var.aws_shot_region}-${var.environment}-wallet-pri-secondary-${count.index + 1}-${split("-", element(var.wallet_azs, count.index))[2]}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}
