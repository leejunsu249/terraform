resource "aws_iam_role" "lambda_role" {
  count = var.environment == "prd" ? 1 : 0

  name = "lambda-cloudwatch-role"

  managed_policy_arns = [aws_iam_policy.lambda_watch_policy[0].arn]
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
  count = var.environment == "prd" ? 1 : 0

  name = "lambda-watch-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "kms:Decrypt"
        Resource = [
          "${aws_kms_key.ec2.arn}",
        ]
      },
      {
        Effect = "Allow"
        Action = "logs:CreateLogGroup"
        Resource = [
          "arn:aws:logs:us-east-2:${data.aws_caller_identity.current.account_id}:*",
          "arn:aws:logs:ap-northeast-2:${data.aws_caller_identity.current.account_id}:*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = [
          "arn:aws:logs:us-east-2:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/lambda-ue2-${var.environment}-naemo-infra-noti:*",
          "arn:aws:logs:us-east-2:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/lambda-ue2-${var.environment}-naemo-app-noti:*",
          "arn:aws:logs:ap-northeast-2:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/lambda-an2-${var.environment}-naemo-infra-noti:*",
          "arn:aws:logs:ap-northeast-2:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/lambda-an2-${var.environment}-naemo-app-noti:*"
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
