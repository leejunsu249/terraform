output "ec2_private_key" {
  value     = tls_private_key.ec2_private_key.private_key_pem
  sensitive = true
}

output "gitlab_private_key" {
  value     = tls_private_key.gitlab_private_key.private_key_pem
  sensitive = true
}

output "sonarqube_private_key" {
  value     = tls_private_key.sonarqube_private_key.private_key_pem
  sensitive = true
}

output "coderay_private_key" {
  value     = tls_private_key.coderay_private_key.private_key_pem
  sensitive = true
}

output eks_role_arn {
  value = module.gitlab_runner_cluster.cluster_iam_role_arn
}

output configmap {
  value = module.gitlab_runner_cluster.aws_auth_configmap_yaml
}

output cluster_arn {
  value = module.gitlab_runner_cluster.cluster_arn
}

output "kms_ec2_id" {
  value = aws_kms_key.ec2.key_id
}

output "elb_log_bucket_arn" {
  value     = aws_s3_bucket.elb_logs.arn
}

output "flow_log_bucket_arn" {
  value     = aws_s3_bucket.flow_logs.arn
}