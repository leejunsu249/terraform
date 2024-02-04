resource "aws_subnet" "private_lb_subnet_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_lb_sub_1_cidr
  map_public_ip_on_launch = false
  availability_zone = var.azs[0]

  tags = {
    Name = "sbn-${var.aws_region_shot}-${var.environment}-pri-lb-1-2a",
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "private_lb_subnet_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_lb_sub_2_cidr
  map_public_ip_on_launch = false
  availability_zone = var.azs[1]

  tags = {
    Name = "sbn-${var.aws_region_shot}-${var.environment}-pri-lb-2-2b"
    "kubernetes.io/role/internal-elb" = 1    
  }
}

resource "aws_subnet" "private_inner_subnet_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_inner_sub_1_cidr
  map_public_ip_on_launch = false
  availability_zone = var.azs[0]

  tags = {
    Name = "sbn-${var.aws_region_shot}-${var.environment}-pri-inner-1-2a"
  }
}

resource "aws_subnet" "private_inner_subnet_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_inner_sub_2_cidr
  map_public_ip_on_launch = false
  availability_zone = var.azs[1]

  tags = {
    Name = "sbn-${var.aws_region_shot}-${var.environment}-pri-inner-2-2b"
  }
}

resource "aws_subnet" "private_app_subnet_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_app_sub_1_cidr
  map_public_ip_on_launch = false
  availability_zone = var.azs[0]

  tags = {
    Name = "sbn-${var.aws_region_shot}-${var.environment}-pri-app-1-2a"
  }
}

resource "aws_subnet" "private_app_subnet_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_app_sub_2_cidr
  map_public_ip_on_launch = false
  availability_zone = var.azs[1]

  tags = {
    Name = "sbn-${var.aws_region_shot}-${var.environment}-pri-app-2-2b"
  }
}