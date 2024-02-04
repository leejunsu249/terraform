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

variable "eks_node_instance_types" {
  type = list
}

variable "capacity_type" {
  type = string
}

variable "log_group_retention" {
  type = string
}

variable "management_bottlerocket_node" {
  type = any
}

variable "marketplace_bottlerocket_node" {
  type = any
}

variable "feature_bottlerocket_node" {
  type = any
  default = {}
}

variable "middleware_bottlerocket_node" {
  type = any
}

variable "metaverse_bottlerocket_node" {
  type = any
  default = {}
}

variable "launchpad_bottlerocket_node" {
  type = any
  default = {}
}

variable "common_bottlerocket_node" {
  type = any
  default = {}
}

variable "batch_bottlerocket_node" {
  type = any
  default = {}
}

variable "kms_acm_arn" {
  type = string
  default = null
}

### workernode spec change configuration ### 
variable "feature_bottlerocket_node_v2" {
  type = any
  default = {}
}

variable "management_bottlerocket_node_v2" {
  type = any
  default = {}
}

variable "middleware_bottlerocket_node_v2" {
  type = any
  default = {}
}

variable "launchpad_bottlerocket_node_v2" {
  type = any
  default = {}
}

variable "common_bottlerocket_node_v2" {
  type = any
  default = {}
}

variable "marketplace_bottlerocket_node_v2" {
  type = any
  default = {}
}

variable "batch_bottlerocket_node_v2" {
  type = any
  default = {}
}

variable "common_worker_spec_change" {
  type = bool
  default = false
}
variable "market_worker_spec_change" {
  type = bool
  default = false
}

variable "batch_worker_spec_change" {
  type = bool
  default = false
}
variable "old_common_worker_delete" {
  type = bool
  default = false
}

variable "version_update" {
  type = bool
  default = false
}

