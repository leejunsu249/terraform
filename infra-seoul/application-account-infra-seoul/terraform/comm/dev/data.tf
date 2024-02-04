data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.environment}-an2"
    key    = "${var.environment}/network.tfstate"
    region = "ap-northeast-2"
    profile = "dev"
  }
}

data "terraform_remote_state" "network_ue2" {
  backend = "s3"
  config = {
    bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.environment}-ue2"
    key    = "${var.environment}/network.tfstate"
    region = "us-east-2"
    profile = "dev"
  }
}

data "terraform_remote_state" "comm" {
  backend = "s3"
  config = {
    bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.environment}-ue2"
    key    = "${var.environment}/comm.tfstate"
    region = "us-east-2"
    profile = "dev"
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_default_tags" "current" {}

data "template_file" "userdata_bcs" {
  template = "${file("scripts/user-data-bcs.sh")}"
  vars = {
    keypair_bcs = "${tls_private_key.bcs_private_key.public_key_openssh}"
  }
}

data "template_file" "userdata_wallet" {
  template = "${file("scripts/user-data-wallet.sh")}"
  vars = {
    keypair_wallet = "${tls_private_key.wallet_private_key.public_key_openssh}"
  }
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
