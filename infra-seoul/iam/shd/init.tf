provider "aws"{
 region = var.region
 profile = var.profile
}


resource "aws_s3_bucket" "iam_tfstate"{
 bucket = "s3-an2-shd-iam-manage-tfstate"
 force_destroy = true
 versioning {
  enabled = true
 }
}

resource "aws_dynamodb_table" "iam_shd_terraform_state_lock" {
 name= "dynamo-an2-shd-terraform-lock"
 hash_key = "LockID"
 billing_mode = "PAY_PER_REQUEST"

 attribute{
  name = "LockID"
  type = "S"
 }
}

