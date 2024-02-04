# dev 
# terraform {
#   backend "s3" {
#       bucket         = "s3-ue2-dev-new-apps-manage-tfstate" 
#       key            = "dev/new_apps_terraform.tfstate"
#       region         = "us-east-2"
#       encrypt        = true
#       dynamodb_table = "dynamo-ue2-dev-new-app-terraform-lock"
#       profile = "dev"
#   }
# }

# stg
# terraform {
#   backend "s3" {
#       bucket         = "s3-ue2-stg-new-apps-manage-tfstate" 
#       key            = "stg/new_apps_terraform.tfstate"
#       region         = "us-east-2"
#       encrypt        = true
#       dynamodb_table = "dynamo-ue2-stg-new-app-terraform-lock"
#       profile = "stg"
#   }
# }

# prd
# terraform {
#   backend "s3" {
#       bucket         = "s3-ue2-prd-new-apps-manage-tfstate" 
#       key            = "prd/new_apps_terraform.tfstate"
#       region         = "us-east-2"
#       encrypt        = true
#       dynamodb_table = "dynamo-ue2-prd-new-app-terraform-lock"
#       profile = "prd"
#   }
# }
