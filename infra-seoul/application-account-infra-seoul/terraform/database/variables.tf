variable "aws_region" {
  type = string
}

variable "aws_shot_region" {
  type = string
}

variable "environment" {
  type = string
}

variable "service_name" {
  type = string
}

variable "wallet_service_name" {
  type = string
}

variable "s3_tfstate_file" {
  type = string
}

variable "aws_account_number" {
  type = string
}

variable "bcs_user" {
  type = string
}

variable "bcs_instance_class" {
  type = string
}

variable "bcs_maria_ids" {
  type = any
}

variable "centralwallet_user" {
  type = string
}

variable "centralwallet_mysql_ids" {
  type = any
}

variable "mysql_clusters" {
  type = any
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

variable "comm_redis_node_type" {
  type = string
}

variable "memorydb_user" {
  type = any
}
