terraform {
  backend "s3" {
    bucket = "351894368755-terraform-state-net-an2"
    key    = "net/network.tfstate"
    region = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}