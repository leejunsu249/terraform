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
  description = "aws_shot_region"
  type        = string
  default     = ""
}

variable "aws_an2_shot_region" {
  description = "aws_an2_shot_region"
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

variable "kms_id" {
  description = "kms id"
  type        = string
  default     = null
}

variable "secret_names" {
  description = "create_secret"
  type        = list(string)
  default     = []
}

variable "secret_config" {
  description = "create_secret"
  type        = list(string)
  default     = []
}

variable "temp" {
  default = {
    key1 = "value1"
    key2 = "value2"
    }
}

variable "ohio_eks_oid_app" {
  type = string
  default = null
}

variable "ohio_eks_oid" {
  type = string
  default = null
}

variable "holder_oid" {
  type = string
  default = null
}

variable "front_oid" {
  type = string
  default = null
}

variable "aws_account_number" {
  type = string
  default = null
}

variable "vpc_id" {
  type = string
  default = null
}
variable "wallet_service_name" {
  type = string
  default = null
}

variable "an2_eks_oid_app" {
  type = string
  default = null
}

variable "an2_eks_oid" {
  type = string
  default = null
}

variable "wallet_secret_names" {
  description = "create_secret"
  type        = list(string)
  default     = []
}

variable "wallet_secret_config" {
  description = "create_secret"
  type        = list(string)
  default     = []
}

variable "env_nprd" {
  type = string
  default = null
}

variable "elasticsearch_domain_arn" {
  type = string
  default = null
}

variable "firehose_opensearch_role_arn" {
  type = string
  default = null
}

variable "aws_security_group_opensearch" {
  type = string
  default = null
}

variable "subnet_ids" { 
  type        = list 
  default     = []
}

variable "log_stream_services" { 
  type        = any
  default     = {}
}

variable "service_log_backup_bucket_name" {
  type = string
  default = null
}
