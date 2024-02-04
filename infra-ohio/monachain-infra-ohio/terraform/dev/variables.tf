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
variable "exception_ip_list_remote" {
  type = list
}
variable "exception_ip_list_lgcns" {
  type = list
}
variable "exception_ip_list_thales" {
  type = list
}
variable "monachain_keypair_name" {
  type = string
}

variable "default_ami" {
  type = string
}

variable "monachain_instance_type" {
  type = string
}
