data "terraform_remote_state" "dev_s3" {
  backend = "s3"
  config = {
    bucket = "s3-ue2-dev-new-apps-manage-tfstate" 
    key = "dev/new_apps_terraform.tfstate"
    region = "us-east-2"
    profile ="dev"
  }
}

data "terraform_remote_state" "stg_s3" {
  backend = "s3"
  config = {
    bucket = "s3-ue2-stg-new-apps-manage-tfstate" 
    key = "stg/new_apps_terraform.tfstate"
    region = "us-east-2"
    profile ="stg"
  }
}

data "terraform_remote_state" "prd_s3" {
  backend = "s3"
  config = {
    bucket = "s3-ue2-prd-new-apps-manage-tfstate" 
    key = "prd/new_apps_terraform.tfstate"
    region = "us-east-2"
    profile ="prd"
  }
}

data "aws_cloudfront_cache_policy" "index_page_policy" {
  id = "d5be2d59-6938-44af-ab89-a3300cacf5ee"
}