variable "aws_region" {
  type = string
}

variable "aws_shot_region" {
  type = string
}

variable "environment" {
  type = string
}

variable "ue2_env" {
  type = string
}

variable "wallet_service_name" {
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

variable "manage_bottlerocket_node_v2" {
  type = any
}

variable "central_wallet_bottlerocket_node" {
  type = any
}

variable "central_wallet_bottlerocket_node_v2" {
  type = any
}

variable "backoffice_bottlerocket_node" {
  type = any
}

variable "b_office_bottlerocket_node_v2" {
  type = any
}

variable "feature_bottlerocket_node" {
  type = any
  default = {}
}

variable "vpn_cidr" {
  type = string
}

variable "cluster_encryption_policy" {
  type = string
}


