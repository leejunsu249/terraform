terraform {
  backend "s3" {
    bucket = "351894368755-terraform-state-net-ue2"
    key    = "net/network.tfstate"
    region = "us-east-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}