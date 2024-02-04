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

variable "azs" { type = list(any) }

variable "ec2_keypair_name" {
  type = string
}

variable "bcs_keypair_name" {
  type = string
}

variable "wallet_keypair_name" {
  type = string
}

variable "common_ami" {
  type = string
}

variable "orderer" { type = any }
variable "peer" { type = any }
variable "monarest" { type = any }
variable "monamgr" { type = any }
variable "kms" { type = any }

variable "centralwallet_cognito_name" {
  type = string
}

variable "systemadmin_cognito_name" {
  type = string
}

variable tuna_ip {
  type = string
}
