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

variable "domain" {
  type = string
}

variable "feature_domain" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_secondary_cidrs" {
  type = string
}

variable "azs" {
  type = list(any)
}

variable "private_app_subnets" {
  type = list(any)
}

variable "private_db_subnets" {
  type = list(any)
}

variable "private_inner_subnets" {
  type = list(any)
}

variable "private_lb_subnets" {
  type = list(any)
}

variable "private_secondary_subnets" {
  type = list(any)
}

variable "wallet_vpc_cidr" {
  type = string
}

variable "wallet_vpc_secondary_cidrs" {
  type = string
}

variable "wallet_azs" {
  type = list(any)
}

variable "wallet_private_inner_subnets" {
  type = list(any)
}

variable "wallet_private_lb_subnets" {
  type = list(any)
}

variable "wallet_private_app_subnets" {
  type = list(any)
}

variable "wallet_private_db_subnets" {
  type = list(any)
}

variable "wallet_private_secondary_subnets" {
  type = list(any)
}
