#### monamgr, monarest profile ####

resource "aws_iam_instance_profile" "ec2_bcs_profile" {
  name = "ec2-bcs-profile"
  role = aws_iam_role.ec2_bcs_role.name

  tags = {
    Name = "iami-${var.environment}-ec2-bcs",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "ec2_bcs_role" {
  name = "ec2-bcs-role"

  managed_policy_arns = [
    aws_iam_policy.ec2_bcs_policy.arn, 
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
    ]

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "iamr-${var.environment}-ec2-bcs",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_policy" "ec2_bcs_policy" {
  name = "ec2-bcs-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:DescribeTags"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:ListBucket"
          ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.bcs_deploy_bucket.id}/*",
          "arn:aws:s3:::${aws_s3_bucket.bcs_deploy_bucket.id}"
        ]
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-ec2-bcs",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

#### kms profile ####

resource "aws_iam_instance_profile" "ec2_wallet_profile" {
  name = "ec2-wallet-profile"
  role = aws_iam_role.ec2_wallet_role.name

  tags = {
    Name = "iami-${var.environment}-ec2-wallet",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "ec2_wallet_role" {
  name = "ec2-wallet-role"

  managed_policy_arns = [
    aws_iam_policy.ec2_wallet_policy.arn, 
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
    ]

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "iamr-${var.environment}-ec2-wallet",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_policy" "ec2_wallet_policy" {
  name = "ec2-wallet-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:DescribeTags"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:ListBucket"
          ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.wallet_deploy_bucket.id}/*",
          "arn:aws:s3:::${aws_s3_bucket.wallet_deploy_bucket.id}"
        ]
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-ec2-wallet",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}