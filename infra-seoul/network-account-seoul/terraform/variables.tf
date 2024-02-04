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

variable "account_id" {
  type = string
}

variable "domain" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list
}

variable "egress_public_subnets" {
  type = list
}

variable "egress_private_inner_subnets" {
  type = list
}

variable "egress_protected_nfw_subnets" {
  type = list
}

variable "fivetuple_stateful_rule_group" {
  description = "Config for 5-tuple type stateful rule group"
  type        = list(any)
  default     = []
}

variable "domain_stateful_rule_group" {
  description = "Config for domain type stateful rule group"
  type        = list(any)
  default     = []
}

variable "suricata_stateful_rule_group" {
  description = "Config for Suricata type stateful rule group"
  type        = list(any)
  default     = []
}

variable "stateless_rule_group" {
  description = "Config for stateless rule group"
  type = list(any)
}

variable "stateless_default_actions" {
  description = "Default stateless Action"
  type = string
  default = "forward_to_sfe"
}

variable "stateless_fragment_default_actions" {
  description = "Default Stateless action for fragmented packets"
  type = string
  default = "forward_to_sfe"
}