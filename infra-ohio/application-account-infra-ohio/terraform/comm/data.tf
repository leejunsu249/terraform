data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.environment}-ue2"
    key    = "${var.environment}/network.tfstate"
    region = "us-east-2"
    # profile = "prd"
  }
}

data "terraform_remote_state" "network_an2" {
  backend = "s3"
  config = {
    bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.an2_env}-an2"
    key    = "${var.an2_env}/network.tfstate"
    region = "ap-northeast-2"
    # profile = "prd"
  }
}

data "terraform_remote_state" "comm_an2" {
  backend = "s3"
  config = {
    bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.an2_env}-an2"
    key    = "${var.an2_env}/comm.tfstate"
    region = "ap-northeast-2"
    # profile = "prd"
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_default_tags" "current" {}

data "aws_kms_key" "rds" {
  key_id = "alias/aws/rds"
}

data "aws_iam_policy_document" "ec2_policy" {
  statement {
    sid       = "Enable IAM User Permissions"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
  
  statement {
    sid       = "Allow service-linked role use of the KMS"
    effect    = "Allow"
    actions   = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"]
    }
  }

  statement {
    sid       = "Allow attachment of persistent resources"
    effect    = "Allow"
    actions   = ["kms:CreateGrant"]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"]
    }

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }
}