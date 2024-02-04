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

variable ec2_keypair_name {
  type = string
}

variable bcs_keypair_name {
  type = string
}

variable wallet_keypair_name {
  type = string
}

variable "common_ami" {
  type = string
}

variable "bcs_instance_type" {
  type = string
}

variable "peer1_instance_type" {
  type = string
}

variable "kms" {
  type = any 
}

variable centralwallet_cognito_name {
  type = string
}

variable systemadmin_cognito_name {
  type = string
}

variable tuna_ip {
  type = string
}

variable "kms_acm_arn" {
  type = string
  default = null
}

variable "test_bc_keypair_name" {
  type    =  string
  default = null
}

