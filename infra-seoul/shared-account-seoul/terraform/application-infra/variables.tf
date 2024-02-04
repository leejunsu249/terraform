# Common
variable "aws_region" { type = string }
variable "aws_shot_region" { type = string }
variable "environment" { type = string }
variable "service_name" { type = string }

# ec2.tf
variable "gitlab_repository_instance_type" { type = string }
variable "gitlab_repository_ami" { type = string }
variable "gitlab_bc_repository_instance_type" { type = string }
variable "gitlab_bc_repository_ami" { type = string }
variable "sonarqube_instance_type" { type = string }
variable "sonarqube_ami" { type = string }
variable "dbsafer_instance_type" { type = string }
variable "dbsafer_ami" { type = string }
variable "hiware_instance_type" { type = string }
variable "hiware_ami" { type = string }
variable "eks_working_instance_type" { type = string }
variable "nexus_instance_type" { type = string }
variable "common_ami" { type = string }
variable "common_os_ami" { type = string }

# key.tf
variable "gitlab_keypair_name" { type = string }
variable "sonarqube_keypair_name" { type = string }
variable "ec2_keypair_name" { type = string }

# iam.tf
variable "dev_account" { type = map(any) }
variable "stg_account" { type = map(any) }
variable "prd_account" { type = map(any) }
variable "net_account" { type = map(any) }
