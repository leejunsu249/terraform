resource "aws_iam_role" "lambda_role" {
  name = "lambda-cloudwatch-role"

  managed_policy_arns = [aws_iam_policy.lambda_watch_policy.arn]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
      },
    ]
  })

  tags = {
    Name = "iamr-${var.environment}-lambda-watch-alarm",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_policy" "lambda_watch_policy" {
  name = "lambda-watch-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "kms:Decrypt"
        Resource = [
          "${aws_kms_key.ec2.arn}",
          "${aws_kms_key.ue1-ec2.arn}"
        ]
      },
      {
        Effect = "Allow"
        Action = "logs:CreateLogGroup"
        Resource = [
          "arn:aws:logs:ap-northeast-2:${data.aws_caller_identity.current.account_id}:*",
          "arn:aws:kms:us-east-2:676826599814:key/df919bee-f473-4738-801c-2a299567c95b"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = [
          "arn:aws:logs:ap-northeast-2:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/lambda-an2-${var.environment}-naemo-infra-noti:*",
          "arn:aws:logs:ap-northeast-2:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/lambda-an2-${var.environment}-naemo-app-noti:*",
          "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/lambda-ue1-${var.environment}-aws-console-login-noti:*",
          "arn:aws:logs:ap-northeast-2:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/lambda-an2-${var.environment}-aws-console-login-noti:*",
          "arn:aws:logs:ap-northeast-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/lambda-an1-${var.environment}-aws-console-login-noti:*",
          "arn:aws:logs:ap-northeast-2:676826599814:log-group:/aws/lambda/lambda-an2-shd-aws-console-login-noti:*",
          "arn:aws:logs:us-east-2:676826599814:log-group:/aws/lambda/lambda-ue2-shd-naemo-aws-console-login-noti:*"
        ]
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-lambda-watch-alarm",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role" "lambda_iam_manage_role" {
  name = "lambda-iam-manage-role"

  managed_policy_arns = [aws_iam_policy.lambda_iam_manage_policy.arn]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
      },
    ]
  })

  tags = {
    Name = "iamr-${var.environment}-lambda-iam-manage",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_policy" "lambda_iam_manage_policy" {
  name = "lambda-iam-manage-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "kms:Decrypt"
        Resource = [
          "${aws_kms_key.ec2.arn}"
        ]
      },
      {
        Effect = "Allow"
        Action = "logs:CreateLogGroup"
        Resource = [
          "arn:aws:logs:ap-northeast-2:${data.aws_caller_identity.current.account_id}:*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:ap-northeast-2:676826599814:log-group:/aws/lambda/lambda-an2-shd-none-mfa-user-list:*"
      },
      {
        Effect = "Allow"
        Action = [
          "iam:ListUsers",
          "iam:ListVirtualMFADevices",
          "iam:ListMFADevices"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-lambda-iam-manage",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}
