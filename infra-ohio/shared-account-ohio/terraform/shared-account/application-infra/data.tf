data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "676826599814-terraform-state-shd-ue2"
    key    = "shd/network.tfstate"
    region = "us-east-2"
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_default_tags" "current" {}

data "aws_availability_zones" "az" {}
