variable "aws_region" {
  type = string
}

variable "aws_region_shot" {
  type = string
}

variable "environment" {
  type = string
}

variable "service_name" {
  type = string
}

variable "groups" {
  type = any
}

variable "dev_roles" {
  type = any
}

variable "stg_roles" {
  type = any
}

variable "prd_roles" {
  type = any
}

variable "net_roles" {
  type = any
}

variable "bmeta_dev_roles" {
  type = any
}

variable "users" {
  type = any
}
