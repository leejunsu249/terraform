resource "aws_kms_key" "ec2" {
  description             = "KMS key for ec2"
  deletion_window_in_days = 7
  enable_key_rotation = true
  
  tags = {
    Name = "kms-${var.aws_shot_region}-${var.environment}-ec2" 
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
    aws_kms_key.ec2,
  ]
}