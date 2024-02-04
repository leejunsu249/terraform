# provider "aws"{
#  region = var.region
#  profile = var.environment
# }

provider "aws"{
 alias = "an2"
 region = "ap-northeast-2"
  # profile = var.profile
}

# provider "aws"{
#  alias = "net_ohio"
#  region = "us-east-2"
#  profile = "net"
# }

# provider "aws"{
#  alias = "net_viz"
#  region = "us-east-1"
#  profile = "net"
# }

provider "aws" {
  region = var.region
  # profile = "prd"

  default_tags {
    tags = {
      Environment = var.environment
      Terraform = "True"
    }
  }
}

terraform {
  required_version = ">= 1.1.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.25.0"
    }
  }
}


resource "aws_s3_bucket" "new_app_manage"{
 bucket = "s3-${var.aws_shot_region}-${var.environment}-new-apps-manage-tfstate"
 force_destroy = true
 versioning {
  enabled = true
 }
}

resource "aws_s3_bucket_public_access_block" "new_app_manage" {
  bucket = aws_s3_bucket.new_app_manage.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}


data "aws_iam_policy_document" "allow_access_shd" {
    statement {
        effect = "Allow"

        principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::676826599814:root"]
     }

        actions = [
        "s3:*",
        ]
        resources = [
        "arn:aws:s3:::${aws_s3_bucket.new_app_manage.id}/*",
        "arn:aws:s3:::${aws_s3_bucket.new_app_manage.id}"
        ]
     }
} 

resource "aws_s3_bucket_policy" "state_polcy" {
  bucket = aws_s3_bucket.new_app_manage.id
  policy = data.aws_iam_policy_document.allow_access_shd.json
}

resource "aws_dynamodb_table" "iam_all_ecr_terraform_state_lock" {
 name= "dynamo-${var.aws_shot_region}-${var.environment}-new-app-terraform-lock"
 hash_key = "LockID"
 billing_mode = "PAY_PER_REQUEST"

 attribute{
  name = "LockID"
  type = "S"
 }
}

