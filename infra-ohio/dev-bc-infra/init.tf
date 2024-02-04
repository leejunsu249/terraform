provider "aws"{
 region = var.region
 profile = var.profile
}

provider "aws"{
 alias = "an2"
 region = "ap-northeast-2"
 profile = var.profile
}

## net account 용 ## 
# route53 + ACM
provider "aws"{
 alias = "virginia"
 region = "us-east-1"
 profile = var.net_profile
}

provider "aws"{
 alias = "ohio"
 region = "us-east-2"
 profile = var.net_profile
}


resource "aws_s3_bucket" "bc_new_infra_tfstate"{
 bucket = "s3-ue2-dev-bc-new-manage-tfstate"
 force_destroy = true
 versioning {
  enabled = true
 }
}

resource "aws_dynamodb_table" "bc_new_infra_terraform_state_lock" {
 name= "dynamo-ue2-dev-bc-new-terraform-lock"
 hash_key = "LockID"
 billing_mode = "PAY_PER_REQUEST"
 attribute{
  name = "LockID"
  type = "S"
 }
}
