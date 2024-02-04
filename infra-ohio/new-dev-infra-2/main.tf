provider "aws" {
  region = var.region
  profile = "net"
  default_tags {
    tags = {
      Terraform = "True"
    }
  }
}