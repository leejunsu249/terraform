terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.25.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Terraform = "True"
    }
  }
}

provider "aws" {
  alias   = "virginia"
  region  = "us-east-1"
}