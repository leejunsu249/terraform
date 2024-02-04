# Common
variable "aws_region" { type = string }
variable "aws_shot_region" { type = string }
variable "environment" { type = string }
variable "service_name" { type = string }
variable "aws_account_number" { type = string }

# opensearch.tf
variable "cluster_version" { type = number }
variable "instance_type" { type = string } 
variable "instance_count" { type = number }
variable "availability_zone_count" { type = number }
variable "dedicated_master_enabled" { type = string }
variable "master_instance_type" {
    type = string
    default = ""
}
variable "master_instance_count" {
    type = number
    default = 0
}
variable "subnet_ids" { type = list }
variable "storage_options" { type = list(any) }
variable "cognito_name" { type = string }
variable "cognito_domain" { type = string }
variable "log_stream_services" { type = any }
variable "service_log_backup_bucket_name" { type = string }

