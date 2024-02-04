terraform {
  backend "s3" {
    bucket = "385866877617-terraform-state-dev-ue2"
    key    = "dev/monachain.tfstate"
    region = "us-east-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}