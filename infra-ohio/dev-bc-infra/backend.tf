## backend state file 저장소 
terraform {
  backend "s3" {
      bucket         = "s3-ue2-dev-bc-new-manage-tfstate" 
      key            = "dev/bc_new_infra_terraform.tfstate"
      region         = "us-east-2"
      encrypt        = true
      dynamodb_table = "dynamo-ue2-dev-bc-new-terraform-lock" 
      profile = "dev"
  }
}


