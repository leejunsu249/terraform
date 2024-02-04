terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.25.0"
    }
    local = {
      version = "~> 1.4"
    }
  }
}

data "aws_caller_identity" "current" {
  provider  = aws.dev
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
  alias  = "dev"
  region = var.aws_region

  assume_role {
    role_arn = "arn:aws:iam::385866877617:role/dev-gitlab-role"
  }
}

provider "aws" {
  alias  = "stg"
  region = var.aws_region

  assume_role {
    role_arn = "arn:aws:iam::087942668956:role/stg-gitlab-role"
  }
}

provider "aws" {
  alias  = "prd"
  region = var.aws_region

  assume_role {
    role_arn = "arn:aws:iam::908317417455:role/prd-gitlab-role"
  }
}

provider "aws" {
  alias  = "net"
  region = var.aws_region

  assume_role {
    role_arn = "arn:aws:iam::351894368755:role/net-gitlab-role"
  }
}
