output "vpc_egress_id" {
  value = aws_vpc.egress.id
}

output "egress_public_subnets" {
    value = [aws_subnet.egress_public_subnet_1.id, aws_subnet.egress_public_subnet_2.id]
}

output "egress_protected_nfw_subnets" {
    value = [aws_subnet.egress_protected_nfw_subnet_1.id, aws_subnet.egress_protected_nfw_subnet_2.id]
}

output "egress_private_inner_subnets" {
    value = [aws_subnet.egress_private_inner_subnet_1.id, aws_subnet.egress_private_inner_subnet_2.id]
}
/* 
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
 */
 output "nat_gw_ip" {
   value = [aws_eip.nat_eip_1.public_ip, aws_eip.nat_eip_2.public_ip]
 }

output "tgw_id" {
  value = aws_ec2_transit_gateway.tgw.id
}
