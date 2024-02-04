terraform {
  backend "s3" {
    bucket = "351894368755-terraform-state-net-ue2"
    key    = "net/network_v2.tfstate"
    region = "us-east-2"
    dynamodb_table = "terraform-lock"
    encrypt       = true
  }
}