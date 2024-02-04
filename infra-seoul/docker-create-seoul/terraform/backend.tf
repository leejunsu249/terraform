terraform {
  backend "s3" {
    bucket = "676826599814-terraform-state-shd-an2"
    key    = "shd/docker-images.tfstate"
    region = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}