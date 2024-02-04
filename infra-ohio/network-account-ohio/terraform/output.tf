output "vpc_ingress_id" {
  value = aws_vpc.ingress.id
}

output "vpc_egress_id" {
  value = aws_vpc.egress.id
}

output "vpc_inspection_id" {
  value = aws_vpc.inspection.id
}

output "ingress_public_subnets" {
  value = [aws_subnet.ingress_public_subnet_1.id, aws_subnet.ingress_public_subnet_2.id]
}

output "ingress_private_lb_subnets" {
  value = [aws_subnet.ingress_public_subnet_1.id, aws_subnet.ingress_public_subnet_2.id]
}

output "ingress_private_app_subnets" {
  value = [aws_subnet.ingress_private_app_subnet_1.id, aws_subnet.ingress_private_app_subnet_2.id]
}

output "ingress_private_inner_subnets" {
  value = [aws_subnet.ingress_private_inner_subnet_1.id, aws_subnet.ingress_private_inner_subnet_2.id]
}

output "egress_public_subnets" {
  value = [aws_subnet.egress_public_subnet_1.id, aws_subnet.egress_public_subnet_2.id]
}

output "egress_private_inner_subnets" {
  value = [aws_subnet.egress_private_inner_subnet_1.id, aws_subnet.egress_private_inner_subnet_2.id]
}

output "inspection_private_nfw_subnets" {
  value = [aws_subnet.inspection_private_nfw_subnet_1.id, aws_subnet.inspection_private_nfw_subnet_2.id]
}

output "inspection_private_inner_subnets" {
  value = [aws_subnet.inspection_private_inner_subnet_1.id, aws_subnet.inspection_private_inner_subnet_2.id]
}

output "network_firewall_id" {
  description = "Created Network Firewall ID from network_firewall module"
  value       = aws_networkfirewall_firewall.nfw.id
}

output "network_firewall_arn" {
  description = "Created Network Firewall ARN from network_firewall module"
  value       = aws_networkfirewall_firewall.nfw.arn
}

output "network_firewall_states" {
  description = "Created Network Firewall states"
  value       = flatten(aws_networkfirewall_firewall.nfw.firewall_status[*].sync_states)
}

output "nat_gw_ip" {
  value = [aws_eip.nat_eip_1.public_ip, aws_eip.nat_eip_2.public_ip]
}

output "kms_ec2_id" {
  value = aws_kms_key.ec2.key_id
}

output "public_domain_zone_id" {
  value = aws_route53_zone.public_domain.zone_id
}

output "public_domain_name" {
  value = aws_route53_zone.public_domain.name
}

output "tgw_id" {
  value = aws_ec2_transit_gateway.tgw.id
}

# output "root_cert_arn" {
#   value = aws_acm_certificate.root_domain_cert_virginia.arn
# }

# output "root_cert_domain_name" {
#   value = aws_acm_certificate.root_domain_cert_virginia.domain_name 
# }

# output "root_cert_virginia_arn" {
#   value = aws_acm_certificate.root_cert_virginia.arn
# }

output "firehose_nfw_role_arn" {
  value = aws_iam_role.firehose_nfw_role.arn
}
