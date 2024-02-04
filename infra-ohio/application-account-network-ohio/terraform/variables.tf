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
  type    = string
  default = "mgmt.feature.naemo.io"
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_secondary_cidrs" {
  type = list(any)
}

variable "azs" {
  type = list(any)
}

variable "private_lb_subnets" {
  type = list(any)
}

variable "private_app_subnets" {
  type = list(any)
}

# variable "private_mona_subnets" {
#   type = list
# }

variable "private_db_subnets" {
  type = list(any)
}

variable "private_inner_subnets" {
  type = list(any)
}

variable "private_secondary_subnets" {
  type = list(any)
}

variable "private_batch_subnets" {
  type = list(any)
}

variable "private_monitor_subnets" {
  type = list(any)
}
