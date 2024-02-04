resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "rt-${var.aws_shot_region}-${var.environment}-pri",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route_table_association" "private_inner_subnet_association" {
  count = length(var.private_inner_subnets) > 0 ? length(var.private_inner_subnets) : 0

  subnet_id      = element(aws_subnet.private_inner_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_app_subnet_association" {
  count = length(var.private_app_subnets) > 0 ? length(var.private_app_subnets) : 0

  subnet_id      = element(aws_subnet.private_app_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_db_subnet_association" {
  count = length(var.private_db_subnets) > 0 ? length(var.private_db_subnets) : 0

  subnet_id      = element(aws_subnet.private_db_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_lb_subnet_association" {
  count = length(var.private_lb_subnets) > 0 ? length(var.private_lb_subnets) : 0

  subnet_id      = element(aws_subnet.private_lb_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_secondary_subnet_association" {
  count = length(var.private_secondary_subnets) > 0 ? length(var.private_secondary_subnets) : 0

  subnet_id      = element(aws_subnet.private_secondary_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

##### wallet #####
resource "aws_route_table" "wallet_private_route" {
  vpc_id = aws_vpc.wallet_vpc.id

  tags = {
    Name = "rt-${var.aws_shot_region}-${var.environment}-wallet-pri",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route_table_association" "wallet_private_inner_subnet_association" {
  count = length(var.wallet_private_inner_subnets) > 0 ? length(var.wallet_private_inner_subnets) : 0

  subnet_id      = element(aws_subnet.wallet_private_inner_subnet[*].id, count.index)
  route_table_id = aws_route_table.wallet_private_route.id
}

resource "aws_route_table_association" "wallet_private_app_subnet_association" {
  count = length(var.wallet_private_app_subnets) > 0 ? length(var.wallet_private_app_subnets) : 0

  subnet_id      = element(aws_subnet.wallet_private_app_subnet[*].id, count.index)
  route_table_id = aws_route_table.wallet_private_route.id
}

resource "aws_route_table_association" "wallet_private_db_subnet_association" {
  count = length(var.wallet_private_db_subnets) > 0 ? length(var.wallet_private_db_subnets) : 0

  subnet_id      = element(aws_subnet.wallet_private_db_subnet[*].id, count.index)
  route_table_id = aws_route_table.wallet_private_route.id
}

resource "aws_route_table_association" "wallet_private_lb_subnet_association" {
  count = length(var.wallet_private_lb_subnets) > 0 ? length(var.wallet_private_lb_subnets) : 0

  subnet_id      = element(aws_subnet.wallet_private_lb_subnet[*].id, count.index)
  route_table_id = aws_route_table.wallet_private_route.id
}

resource "aws_route_table_association" "wallet_private_secondary_subnet_association" {
  count = length(var.wallet_private_secondary_subnets) > 0 ? length(var.wallet_private_secondary_subnets) : 0

  subnet_id      = element(aws_subnet.wallet_private_secondary_subnet[*].id, count.index)
  route_table_id = aws_route_table.wallet_private_route.id
}
