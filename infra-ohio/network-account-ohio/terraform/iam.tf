resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2_role.name

  tags = {
    Name = "iami-${var.environment}-ec2",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_iam_role" "ec2_role" {
  name                = "ec2-role"
  managed_policy_arns = [aws_iam_policy.ec2_policy.arn, "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
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
    Name = "iamr-${var.environment}-ec2",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_iam_policy" "ec2_policy" {
  name = "ec2-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:DescribeTags"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-ec2",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_iam_role" "lambda_edge_role" {
  name                = "lambda-edge-role"
  managed_policy_arns = [aws_iam_policy.lambda_edge_policy.arn]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = [
            "lambda.amazonaws.com",
            "edgelambda.amazonaws.com"
          ]
        }
      },
    ]
  })
  tags = {
    Name = "iamr-${var.environment}-lambda-edge",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_iam_policy" "lambda_edge_policy" {
  name = "lambda-edge-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [     
      {
        Effect   = "Allow"
        Action   = "logs:CreateLogGroup"
        Resource = "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = [
          "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/*:*"
        ]
      },
      {
        Action = [
          "iam:CreateServiceLinkedRole",
          "lambda:GetFunction",
          "lambda:EnableReplication",
          "cloudfront:UpdateDistribution",
          "s3:GetObject",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-lambda-edge",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

## kinesis firehose role - waf

resource "aws_iam_role" "firehose_waf_role" {
  name                = "firehose-waf-role"
  managed_policy_arns = [aws_iam_policy.firehose_waf_policy.arn]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = [
            "firehose.amazonaws.com"
          ]
        }
      },
    ]
  })
  tags = {
    Name = "iamr-${var.environment}-firehose-waf",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_iam_policy" "firehose_waf_policy" {
  name = "firehose-waf-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "firehose:DeleteDeliveryStream",
          "firehose:PutRecord",
          "firehose:PutRecordBatch",
          "firehose:UpdateDestination"
        ],
        Resource = [
          "arn:aws:firehose:us-east-1:${data.aws_caller_identity.current.account_id}:deliverystream/aws-waf-logs-prd",
          "arn:aws:firehose:us-east-1:${data.aws_caller_identity.current.account_id}:deliverystream/aws-waf-logs-non-prd"
        ]
      },
      {
        Action = [
          "s3:AbortMultipartUpload",
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:ListBucketMultipartUploads",
          "s3:PutObject",
          "s3:PutObjectAcl",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::aws-waf-logs-naemo",
          "arn:aws:s3:::aws-waf-logs-naemo/*"
        ]
      },
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-firehose-waf",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

## kinesis firehose role - nfw

resource "aws_iam_role" "firehose_nfw_role" {
  name                = "firehose-nfw-role"
  managed_policy_arns = [aws_iam_policy.firehose_nfw_policy.arn]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = [
            "firehose.amazonaws.com"
          ]
        }
      },
    ]
  })
  tags = {
    Name = "iamr-${var.environment}-firehose-nfw",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_iam_policy" "firehose_nfw_policy" {
  name = "firehose-nfw-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "firehose:DeleteDeliveryStream",
          "firehose:PutRecord",
          "firehose:PutRecordBatch",
          "firehose:UpdateDestination"
        ],
        Resource = [
          "arn:aws:firehose:us-east-2:${data.aws_caller_identity.current.account_id}:deliverystream/firehose-ue2-net-nfw-alert",
          "arn:aws:firehose:us-east-2:${data.aws_caller_identity.current.account_id}:deliverystream/firehose-ue2-net-nfw-flow",
          "arn:aws:firehose:ap-northeast-2:${data.aws_caller_identity.current.account_id}:deliverystream/firehose-an2-net-nfw-alert",
          "arn:aws:firehose:ap-northeast-2:${data.aws_caller_identity.current.account_id}:deliverystream/firehose-an2-net-nfw-flow"
        ]
      },
      {
        Action = [
          "s3:AbortMultipartUpload",
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:ListBucketMultipartUploads",
          "s3:PutObject",
          "s3:PutObjectAcl",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::s3-an2-shd-nfw-logs",
          "arn:aws:s3:::s3-an2-shd-nfw-logs/*"
        ]
      },
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-firehose-nfw",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}
