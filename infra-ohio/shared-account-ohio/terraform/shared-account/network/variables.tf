variable "aws_region" {
  type = string
}

variable "aws_region_shot" {
  type = string
}

variable "azs" {
  type = list
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

variable "vpc_cidr" {
  type = string
}

variable "private_lb_sub_1_cidr" {
  type = string
}

variable "private_lb_sub_2_cidr" {
  type = string
}

variable "private_app_sub_1_cidr" {
  type = string
}

variable "private_app_sub_2_cidr" {
  type = string
}

variable "private_inner_sub_1_cidr" {
  type = string
}

variable "private_inner_sub_2_cidr" {
  type = string
}
