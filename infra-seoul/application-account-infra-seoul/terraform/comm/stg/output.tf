output "kms_ec2_id" {
  value = aws_kms_key.ec2.key_id
}

output "kms_ec2_arn" {
  value = aws_kms_key.ec2.arn
}

output "kms_rds_id" {
  value = aws_kms_key.rds.key_id
}

output "kms_rds_arn" {
  value = aws_kms_key.rds.arn
}

output "kms_redis_arn" {
  value = aws_kms_key.redis.arn
}

output "bcs_key_name" {
  value     = aws_key_pair.bcs_keypair.key_name
  sensitive = true
}

output "bcs_private_key" {
  value     = tls_private_key.bcs_private_key.private_key_pem
  sensitive = true
}

output "ec2_private_key" {
  value     = tls_private_key.ec2_private_key.private_key_pem
  sensitive = true
}

output "wallet_private_key" {
  value     = tls_private_key.wallet_private_key.private_key_pem
  sensitive = true
}

output "bcs_monamgr_sg_id" {
  value = aws_security_group.bcs_monamgr_sg.id
}

output "wallet_kms_sg_id" {
  value = aws_security_group.wallet_kms_sg.id
}
