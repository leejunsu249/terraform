terraform {
  backend "s3" {
    bucket = "676826599814-terraform-state-shd-ue2"
    key    = "shd/application.tfstate"
    region = "us-east-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}