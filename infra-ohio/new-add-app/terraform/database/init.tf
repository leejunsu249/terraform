# terraform {
#   required_version = ">= 1.1.4"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "4.25.0"
#     }
#   }
# }


provider "aws" {
  region = var.region
  # profile = "dev"
  default_tags {
    tags = {
      Environment = var.environment
      Terraform = "True"
    }
  }
}



