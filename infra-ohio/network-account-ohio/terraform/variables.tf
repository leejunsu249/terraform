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

variable "public_domain" {
  type = string
}

variable "dev_public_domain" {
  type = string
}

variable "dev_next_public_domain" {
  type = string
}

variable "stg_public_domain" {
  type = string
}

variable "nprd_public_domain" {
  type = string
}

variable "exception_ip_list" {
  type = list
}

variable "exception_ip_list2" {
  type = list
}

variable "domain" {
  type = string
}

variable "vpc_cidr" {
  type = list
}

variable "azs" {
  type = list
}

variable "ingress_public_subnets" {
  type = list
}

variable "ingress_private_lb_subnets" {
  type = list
}

variable "ingress_private_app_subnets" {
  type = list
}

variable "ingress_private_inner_subnets" {
  type = list
}

variable "egress_public_subnets" {
  type = list
}

variable "egress_private_inner_subnets" {
  type = list
}

variable "inspection_private_nfw_subnets" {
  type = list
}

variable "inspection_private_inner_subnets" {
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

variable "s3_buckets" {
  type = map(any)
}

variable "homepage_domain" {
  type = string
}

variable "homepage_domain_xyz" {
  type = string
}

variable "homepage_domain_org" {
  type = string
}

variable "homepage_domain_kr" {
  type = string
}

variable "homepage_domain_net" {
  type = string
}

variable "homepage_domain_cokr" {
  type = string
}

variable "exception_unity_ip_list" {
  type = list
}

