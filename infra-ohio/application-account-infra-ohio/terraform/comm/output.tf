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

output "ec2_profile_id" {
  value = aws_iam_instance_profile.ec2_profile.id
}

output "ec2_key_name" {
  value     = aws_key_pair.ec2_keypair.key_name
  sensitive = true
}

output "ec2_private_key" {
  value     = tls_private_key.ec2_private_key.private_key_pem
  sensitive = true
}

output "lena_private_key" {
  value     = tls_private_key.lena_private_key.private_key_pem
  sensitive = true
}

output "tuna_private_key" {
  value     = tls_private_key.tuna_private_key.private_key_pem
  sensitive = true
}

output "lena_private_ip" {
  value = aws_instance.lenamaneger.private_ip
}

output "tuna_private_ip" {
  value = aws_instance.tuna.private_ip
}

output "bcs_key_name" {
  value     = var.environment == "stg" ? aws_key_pair.bcs_keypair[0].key_name : null
  sensitive = true
}

output "bcs_private_key" {
  value     = var.environment == "stg" ? tls_private_key.bcs_private_key[0].private_key_pem : null
  sensitive = true
}

output "search_key_name" {
  value     = aws_key_pair.search_keypair.key_name
  sensitive = true
}

output "search_private_key" {
  value     = tls_private_key.search_private_key.private_key_pem
  sensitive = true
}

output "search_sg_id" {
  value     = aws_security_group.search_sg.id
  sensitive = true
}
