resource "aws_kms_key" "ec2" {
  description             = "KMS key for ec2"
  deletion_window_in_days = 7
  enable_key_rotation = true

  tags = {
    Name = "kms-${var.aws_shot_region}-${var.environment}-ec2",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_kms_alias" "ec2" {
    name = "alias/kms-${var.aws_shot_region}-${var.environment}-ec2"
    target_key_id = aws_kms_key.ec2.key_id
}

resource "aws_ebs_encryption_by_default" "ebs_encrypt" {
  enabled = true
}

resource "aws_ebs_default_kms_key" "ebs_kms" {
  key_arn = aws_kms_key.ec2.arn

  depends_on = [
    aws_kms_key.ec2
  ]
}

resource "aws_kms_key" "ue1-ec2" {
  provider = aws.virginia

  description             = "KMS key for ec2"
  deletion_window_in_days = 7
  enable_key_rotation = true

  tags = {
    Name = "kms-${var.aws_shot_region}-${var.environment}-ec2",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_kms_alias" "ue1-ec2" {
  provider = aws.virginia
  
  name = "alias/kms-${var.aws_shot_region}-${var.environment}-ec2"
  target_key_id = aws_kms_key.ue1-ec2.key_id
}

# resource "aws_kms_key" "s3" {
#   description             = "KMS key for s3"
#   deletion_window_in_days = 7
#   enable_key_rotation = true
#   policy = data.aws_iam_policy_document.s3_policy.json
#   tags = {
#       Name = "kms-${var.aws_shot_region}-${var.environment}-s3"
#   }
# }

# resource "aws_kms_alias" "s3" {
#   name = "alias/kms-${var.aws_shot_region}-${var.environment}-s3"
#   target_key_id = aws_kms_key.s3.key_id
# }

# resource "aws_kms_key" "s3_ohio" {
#   provider = aws.Ohio
#   description             = "KMS key for s3"
#   deletion_window_in_days = 7
#   enable_key_rotation = true

#   tags = {
#       Name = "kms-${var.aws_shot_region}-${var.environment}-s3-ohio"
#   }
# }

# resource "aws_kms_alias" "s3_ohio" {
#   provider = aws.Ohio
#   name = "alias/kms-${var.aws_shot_region}-${var.environment}-s3-ohio"
#   target_key_id = aws_kms_key.s3_ohio.key_id
# }