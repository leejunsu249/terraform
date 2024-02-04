resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "rt-${var.aws_region_shot}-${var.environment}-pri",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route_table_association" "private_inner_sub1_association" {
  subnet_id      = aws_subnet.private_inner_subnet_1.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_inner_sub2_association" {
  subnet_id      = aws_subnet.private_inner_subnet_2.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_lb_sub_1_association" {
  subnet_id      = aws_subnet.private_lb_subnet_1.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_lb_sub_2_association" {
  subnet_id      = aws_subnet.private_lb_subnet_2.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_app_sub_1_association" {
  subnet_id      = aws_subnet.private_app_subnet_1.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_app_sub_2_association" {
  subnet_id      = aws_subnet.private_app_subnet_2.id
  route_table_id = aws_route_table.private_route.id
}
