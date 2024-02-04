# Common
variable "aws_region" { type = string }
variable "aws_shot_region" { type = string }
variable "environment" { type = string }
variable "service_name" { type = string }

# temp inbound ip list
variable "cluster_exception_ip_list" { type = list }

# ec2.tf
variable gitlab_repository_instance_type { type = string }
variable gitlab_repository_ami { type = string }
variable gitlab_bc_repository_instance_type { type = string }
variable gitlab_bc_repository_ami { type = string }
variable sonarqube_instance_type { type = string }
variable sonarqube_ami { type = string }
variable coderay_instance_type { type = string }
variable coderay_ami { type = string }

# key.tf
variable gitlab_keypair_name { type = string }
variable sonarqube_keypair_name { type = string }
variable ec2_keypair_name { type = string }
variable coderay_keypair_name { type = string }

# iam.tf
variable dev_account { type = map }
variable stg_account { type = map }
variable prd_account { type = map }
variable net_account { type = map }
