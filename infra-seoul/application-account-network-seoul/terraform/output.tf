output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "cluster_subnets" {
  value = concat(aws_subnet.private_lb_subnet[*].id, aws_subnet.private_app_subnet[*].id)
}

output "lb_subnets" {
  value = aws_subnet.private_lb_subnet[*].id
}

output "lb_cidr_blocks" {
  value = aws_subnet.private_lb_subnet[*].cidr_block
}

output "inner_subnets" {
  value = aws_subnet.private_inner_subnet[*].id
}

output "app_subnets" {
  value = aws_subnet.private_app_subnet[*].id
}

output "app_cidr_blocks" {
  value = aws_subnet.private_app_subnet[*].cidr_block
}

output "db_subnets" {
  value = aws_subnet.private_db_subnet[*].id
}

output "db_cidr_blocks" {
  value = aws_subnet.private_db_subnet[*].cidr_block
}

output "app_secondary_subnets" {
  value = aws_subnet.private_secondary_subnet[*].id
}

output "app_secondary_cidr_blocks" {
  value = aws_subnet.private_secondary_subnet[*].cidr_block
}

output "domain_zone_id" {
  value = aws_route53_zone.domain.zone_id
}

output "domain_name" {
  value = var.domain
}

output "s3_vpc_gw_id" {
  value = aws_vpc_endpoint.s3-gw-endpoint.id
}

#####  wallet #####

output "wallet_vpc_id" {
  value = aws_vpc.wallet_vpc.id
}

output "wallet_cluster_subnets" {
  value = concat(aws_subnet.wallet_private_lb_subnet[*].id, aws_subnet.wallet_private_app_subnet[*].id)
}

output "wallet_lb_subnets" {
  value = aws_subnet.wallet_private_lb_subnet[*].id
}

output "wallet_lb_cidr_blocks" {
  value = aws_subnet.wallet_private_lb_subnet[*].cidr_block
}

output "wallet_inner_subnets" {
  value = aws_subnet.wallet_private_inner_subnet[*].id
}

output "wallet_app_subnets" {
  value = aws_subnet.wallet_private_app_subnet[*].id
}

output "wallet_app_cidr_blocks" {
  value = aws_subnet.wallet_private_app_subnet[*].cidr_block
}

output "wallet_db_subnets" {
  value = aws_subnet.wallet_private_db_subnet[*].id
}

output "wallet_db_cidr_blocks" {
  value = aws_subnet.wallet_private_db_subnet[*].cidr_block
}

output "wallet_app_secondary_subnets" {
  value = aws_subnet.wallet_private_secondary_subnet[*].id
}

output "wallet_app_secondary_cidr_blocks" {
  value = aws_subnet.wallet_private_secondary_subnet[*].cidr_block
}

output "wallet_s3_vpc_gw_id" {
  value = aws_vpc_endpoint.wallet_s3-gw-endpoint.id
}
