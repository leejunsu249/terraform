data "aws_iam_policy_document" "cognito_os_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "cognito-idp:DescribeUserPool",
      "cognito-idp:CreateUserPoolClient",
      "cognito-idp:DeleteUserPoolClient",
      "cognito-idp:DescribeUserPoolClient",
      "cognito-idp:AdminInitiateAuth",
      "cognito-idp:AdminUserGlobalSignOut",
      "cognito-idp:ListUserPoolClients",
      "cognito-identity:DescribeIdentityPool",
      "cognito-identity:UpdateIdentityPool",
      "cognito-identity:SetIdentityPoolRoles",
      "cognito-identity:GetIdentityPoolRoles"
    ]
    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "os_assume_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["es.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "os_access_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = ["es:*"]
    resources = ["arn:aws:es:${var.aws_region}:${data.aws_caller_identity.current.account_id}:domain/opensearch-${var.aws_shot_region}-${var.environment}-${var.service_name}/*"]
  }
}

resource "aws_iam_policy" "cognito_os_policy" {
  name = "${var.cognito_name}-cognito-access-os-policy"
  policy = data.aws_iam_policy_document.cognito_os_policy.json

  tags = {
    Name = "iamp-${var.aws_shot_region}-${var.environment}-${var.service_name}-${var.cognito_name}-cognito-access-os",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }  
}

resource "aws_iam_role" "cognito_os_role" {
  name = "${var.cognito_name}-cognito-access-os-role"
  assume_role_policy = data.aws_iam_policy_document.os_assume_policy.json

  tags = {
    Name = "iamr-${var.aws_shot_region}-${var.environment}-${var.service_name}-${var.cognito_name}-cognito-access-os",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role_policy_attachment" "cognito_os_attach" {
  role       = aws_iam_role.cognito_os_role.name
  policy_arn = aws_iam_policy.cognito_os_policy.arn
}

resource "aws_iam_role" "opensearch_master_role" {
  name = "${var.cognito_name}-master-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow",
        "Principal": {
            "Federated": "cognito-identity.amazonaws.com"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringEquals": {
            "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.identity_pool.id}"
          },
          "ForAnyValue:StringLike": {
            "cognito-identity.amazonaws.com:amr": "authenticated"
          }
        }
      }
    ]
  })

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.aws_shot_region}-${var.environment}-${var.service_name}-${var.cognito_name}-master-group-role",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role" "opensearch_developer_role" {
  name = "${var.cognito_name}-developer-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow",
        "Principal": {
            "Federated": "cognito-identity.amazonaws.com"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringEquals": {
            "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.identity_pool.id}"
          },
          "ForAnyValue:StringLike": {
            "cognito-identity.amazonaws.com:amr": "authenticated"
          }
        }
      }
    ]
  })

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.aws_shot_region}-${var.environment}-${var.service_name}-${var.cognito_name}-developer-group-role",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role" "firehose_opensearch_role" {
  name = "firehose-opensearch-role"

  managed_policy_arns = [aws_iam_policy.firehose_opensearch_policy.arn]
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
    Name = "iamr-${var.environment}-firehose-opensearch",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_policy" "firehose_opensearch_policy" {
  name = "firehose-opensearch-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "es:*"
        ],
        Resource = [
        "${aws_elasticsearch_domain.opensearch.arn}",
        "${aws_elasticsearch_domain.opensearch.arn}/*"
        ]
      },      
      {
        Effect = "Allow"       
        Action = [
          "ec2:DescribeVpcs",
          "ec2:DescribeVpcAttribute",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeNetworkInterfaces",
          "ec2:CreateNetworkInterface",
          "ec2:CreateNetworkInterfacePermission",
          "ec2:DeleteNetworkInterface"
        ],
        Resource = [
          "*"
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
          "arn:aws:s3:::${var.service_log_backup_bucket_name}",
          "arn:aws:s3:::${var.service_log_backup_bucket_name}/*"
        ]
      },
      {
        Effect= "Allow",
        Action= [
          "lambda:InvokeFunction",
          "lambda:GetFunctionConfiguration"
        ],
        Resource = [
          "*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "kms:Decrypt"
        ],
        Resource = [
          "arn:aws:kms:${var.aws_region}:${var.aws_account_number}:key/%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%"
        ],
        Condition = {
          StringEquals = {
            "kms:ViaService": "kinesis.${var.aws_region}.amazonaws.com"
          },
          StringLike = {
            "kms:EncryptionContext:aws:kinesis:arn": "arn:aws:kinesis:${var.aws_region}:${var.aws_account_number}:stream/%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%"
          }
        }
      },
      {
        Effect = "Allow",
        Action = [
          "kms:GenerateDataKey",
          "kms:Decrypt"
        ],
        Resource = [
          "arn:aws:kms:${var.aws_region}:${var.aws_account_number}:key/%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%"
        ],
        Condition = {
          StringEquals = {
            "kms:ViaService": "s3.${var.aws_region}.amazonaws.com"
          },
          StringLike = {
            "kms:EncryptionContext:aws:s3:arn": [
              "arn:aws:s3:::%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%/*",
              "arn:aws:s3:::%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%"
            ]
          }
        }
      },
      {
        Effect = "Allow",
        Action = [
          "kinesis:DescribeStream",
          "kinesis:GetShardIterator",
          "kinesis:GetRecords",
          "kinesis:ListShards"
        ],
        Resource = "arn:aws:kinesis:${var.aws_region}:${var.aws_account_number}:stream/%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%"
      },
      {
        Effect = "Allow",
        Action = [
          "logs:PutLogEvents"
        ],
        Resource = [
          "arn:aws:logs:${var.aws_region}:${var.aws_account_number}:log-group:/aws/kinesisfirehose/*:log-stream:*",
          "arn:aws:logs:${var.aws_region}:${var.aws_account_number}:%FIREHOSE_POLICY_TEMPLATE_PLACEHOLDER%:log-stream:*"
        ]
      }
    ]
  })

  lifecycle { ignore_changes = [policy] }

  tags = {
    Name = "iamp-${var.environment}-firehose-opensearch",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}
