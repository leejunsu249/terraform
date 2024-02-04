output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "cluster_subnets" {
  value = [aws_subnet.private_lb_subnet_1.id, aws_subnet.private_lb_subnet_2.id, aws_subnet.private_app_subnet_1.id, aws_subnet.private_app_subnet_2.id]
}

output "node_subnets" {
  value = [aws_subnet.private_app_subnet_1.id, aws_subnet.private_app_subnet_2.id]
}

output "node_cidr_blocks" {
  value = [aws_subnet.private_app_subnet_1.cidr_block, aws_subnet.private_app_subnet_2.cidr_block]
}

output "domain_zone_id" {
  value = aws_route53_zone.domain.zone_id
}

output "domain_name" {
  value = var.domain
}