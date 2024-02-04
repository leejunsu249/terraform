terraform {
  backend "s3" {
      bucket         = "s3-an2-shd-iam-manage-tfstate" 
      key            = "shd-state/terraform.tfstate"
      region         = "ap-northeast-2"
      encrypt        = true
      dynamodb_table = "terraform-lock" 
      profile = "shd"
  }


}

