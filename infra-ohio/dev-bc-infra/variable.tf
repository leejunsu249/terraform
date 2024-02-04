variable "region" {
  description = "aws region"
  default = ""  
}

variable "profile" {
  description = "aws config profile"
  default = ""
}

variable "repo_names" {
  description = "create_ecr"
  type        = list(string)
  default     = []
}

variable "create_ecr" {
  description = "create_ecr"
  type        = bool
  default     = true
}

variable "aws_shot_region" {
  description = "aws_ohio_shot_region"
  type        = string
  default     = ""
}

variable "aws_an2_shot_region" {
  description = "aws_seoul_shot_region"
  type        = string
  default     = ""
}

variable "environment" {
  description = "environment"
  type        = string
  default     = ""
}

variable "service_name" {
  description = "service_name"
  type        = string
  default     = ""
}

variable "wallet_service_name" {
  description = "service_name"
  type        = string
  default     = ""
}

variable "unity_s3_role_name" {
  description = "unity_s3_role_name"
  type        = string
  default     = ""
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

variable "cloudfront_marketplace_bc_oai" {
  type = string
  default = ""
}

variable "cloudfront_creatoradmin_bc_oai" {
  type = string
  default = ""  
}

variable "cloudfront_creatoradmin_oai_bc" {
  type = string
  default = ""  
}

## new 
# variable "dev_bc_public_domain" {
#   type = string
# }

## new 
variable "dev_new_public_domain" {
  type = string
}

variable "dev_bc_public_domain" {
  type = string
}


variable "net_profile" {
  type = string
}


variable marketplace_cognito_name {
  type = string
}

variable "secret_names" {
  description = "create_secret"
  type        = list(string)
  default     = []
}

variable "secret_names_an2" {
  description = "create_secret_an2"
  type        = list(string)
  default     = []
}

variable systemadmin_cognito_name {
  type = string
}

variable "kms_id" {
  description = "kms id"
  type        = string
  default     = null
}

variable "temp" {
  default = {
    key1 = "value1"
    key2 = "value2"
    }
}

variable wallet_centralwallet_cognito_name {
  type = string
}

variable wallet_systemadmin_cognito_name {
  type = string
}

variable "eks_cluster_node_sg_id" {
  type    = string
  default = null
}

variable "an2_eks_cluster_node_sg_id" {
  type    = string
  default = null
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "an2_vpc_id" {
  type    = string
  default = ""
}

variable "subnet_id" {
  type    = list(string)
  default = []
}

variable "an2_subnet_id" {
  type    = list(string)
  default = []
}

variable "kms_redis_arn" {
  type    = string
  default = null
}

variable "an2_kms_redis_arn" {
  type    = string
  default = null
}

variable "redis_global_replication" {
  type = bool
}

variable "auth_redis_node_type" {
  type = string
}

variable "session_redis_node_type" {
  type = string
}

variable "redis_multi_az" {
  type = bool
}

variable "cluster_mode" {
  type = bool
}

variable "parameter" {
  type = list(object({
    name  = string
    value = string
  }))
  default     = []
  description = "A list of Redis parameters to apply. Note that parameters may differ from one Redis family to another"
}

variable "redis_password_spacial" {
  type = bool
}

variable "autoscaling_enabled" {
  type    = bool
  default = false
}

variable "autoscaling_min_capacity" {
  type    = number
  default = null
}

variable "autoscaling_max_capacity" {
  type    = number
  default = null
}

variable "predefined_metric_type" {
  type    = string
  default = null
}

variable "autoscaling_target_cpu" {
  type    = number
  default = null
}

variable "autoscaling_target_connections" {
  type    = number
  default = null
}