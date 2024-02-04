variable "aws_region" {
  type = string
}

variable "aws_shot_region" {
  type = string
}

variable "environment" {
  type = string
}

variable "an2_env" {
  type = string
}

variable "service_name" {
  type = string
}

variable "notification_ecr_name" {
  type = any
}

variable "marketplace_ecr_name" {
  type = any
}

variable "systemadmin_be_ecr_name" {
  type = any
}

variable "systemadmin_fe_ecr_name" {
  type = any
}

variable "centralwallet_fe_ecr_name" {
  type = any
}

variable "centralwallet_be_ecr_name" {
  type = any
}

variable "launchpadruntime_ecr_name" {
  type = any
}

variable "metaverse_ecr_name" {
  type = any
}

variable "kafka_ecr_name" {
  type = any
}

variable "feature_ecr_name" {
  type = any
}

variable ec2_keypair_name {
  type = string
}

variable lena_keypair_name {
  type = string
}

variable tuna_keypair_name {
  type = string
}

variable marketplace_cognito_name {
  type = string
}

variable systemadmin_cognito_name {
  type = string
}

variable "common_ami" {
  type = string
}

variable "lena_instance_type" {
  type = string
}

variable "tuna_instance_type" {
  type = string
}

variable "search_instance_type" {
  type = string
}

variable "eth_middleware_ecr_name" {
  type = string
}

variable "eth_batch_ecr_name" {
  type = string
}

variable "eth_block_confirmation_ecr_name" {
  type = string
}

variable "sol_middleware_ecr_name" {
  type = string
}

variable "sol_batch_ecr_name" {
  type = string
}

variable "sol_block_confirmation_ecr_name" {
  type = string
}

variable "bc_centralwallet_ecr_name" {
  type = string
}

variable "blockchain_cache_ecr_name" {
  type = string
}

variable "cloudfront_marketplace_oai" {
  type = string
}

variable "cloudfront_creatoradmin_oai" {
  type = string
}

variable "cloudfront_marketplace_next_oai" {
  type = string
  default = ""
}

variable "cloudfront_creatoradmin_next_oai" {
  type = string
  default = ""  
}

variable "cloudfront_homepage_oai" {
  type = string
  default = ""
}

variable "s3_vpce_gw" {
  type = string
}

variable "unity_s3_role_name" {
  type = string
}

variable "vpn_cidr" {
  type = string
}

variable "search_ecr_name" {
  type = any
}

variable "aws_account_number" {
  type = string
  default = ""
}

