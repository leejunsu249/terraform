terraform {
  required_version = ">= 1.1.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.8.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  # profile = "prd"

  default_tags {
    tags = {
      Environment = var.environment
      Terraform = "True"
    }
  }
}