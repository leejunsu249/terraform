resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "rt-${var.aws_shot_region}-${var.environment}-pri",
    Network                     = "RT",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = ""
  }
}

resource "aws_route_table_association" "private_inner_subnet_association" {
  count = length(var.private_inner_subnets) > 0 ? length(var.private_inner_subnets) : 0

  subnet_id      = element(aws_subnet.private_inner_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_lb_subnet_association" {
  count = length(var.private_lb_subnets) > 0 ? length(var.private_lb_subnets) : 0

  subnet_id      = element(aws_subnet.private_lb_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_app_subnet_association" {
  count = length(var.private_app_subnets) > 0 ? length(var.private_app_subnets) : 0

  subnet_id      = element(aws_subnet.private_app_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

# resource "aws_route_table_association" "private_mona_subnet_association" {
#   count = length(var.private_mona_subnets) > 0 ? length(var.private_mona_subnets) : 0

#   subnet_id      =element(aws_subnet.private_mona_subnet[*].id, count.index)
#   route_table_id = aws_route_table.private_route.id
# }

resource "aws_route_table_association" "private_db_subnet_association" {
  count = length(var.private_db_subnets) > 0 ? length(var.private_db_subnets) : 0

  subnet_id      = element(aws_subnet.private_db_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_secondary_subnet_association" {
  count = length(var.private_secondary_subnets) > 0 ? length(var.private_secondary_subnets) : 0

  subnet_id      = element(aws_subnet.private_secondary_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_batch_subnet_association" {
  count = length(var.private_batch_subnets) > 0 ? length(var.private_batch_subnets) : 0

  subnet_id      = element(aws_subnet.private_batch_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_monitor_subnet_association" {
  count = length(var.private_monitor_subnets) > 0 ? length(var.private_monitor_subnets) : 0

  subnet_id      = element(aws_subnet.private_monitor_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}
