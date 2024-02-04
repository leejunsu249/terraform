resource "aws_iam_role" "external_dns_role" {
  name = "external-dns-an2-role"

  managed_policy_arns = [aws_iam_policy.external_dns_policy.arn]

  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${module.app_cluster.oidc_provider_arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${module.app_cluster.oidc_provider}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  tags = {
    Name = "iamr-${var.environment}-external-dns-an2",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_policy" "external_dns_policy" {
  name = "external-dns-an2-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ChangeResourceRecordSets"
        ],
        "Resource" : [
          "arn:aws:route53:::hostedzone/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-external-dns-an2"
  }
}

resource "aws_iam_role" "external_secret_role" {
  name = "external-secret-an2-role"

  managed_policy_arns = [aws_iam_policy.external_secret_policy.arn]

  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${module.app_cluster.oidc_provider_arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${module.app_cluster.oidc_provider}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  tags = {
    Name = "iamr-${var.environment}-external-secret-an2",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_policy" "external_secret_policy" {
  name = "external-secret-an2-policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "kms:GetPublicKey",
          "kms:Decrypt",
          "kms:ListKeyPolicies",
          "secretsmanager:DescribeSecret",
          "kms:ListRetirableGrants",
          "ssm:GetParameterHistory",
          "kms:GetKeyPolicy",
          "kms:ListResourceTags",
          "ssm:GetParameters",
          "ssm:GetParameter",
          "kms:ListGrants",
          "secretsmanager:ListSecretVersionIds",
          "kms:GetParametersForImport",
          "kms:DescribeCustomKeyStores",
          "kms:ListKeys",
          "secretsmanager:GetSecretValue",
          "kms:GetKeyRotationStatus",
          "kms:Encrypt",
          "ssm:DescribeParameters",
          "kms:ListAliases",
          "kms:DescribeKey",
          "ssm:GetParametersByPath",
          "secretsmanager:ListSecrets"
        ],
        "Resource" : "*"
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-external-secret-an2",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role" "cluster_autoscaler_role" {
  name = "cluster-autoscaler-an2-role"

  managed_policy_arns = [aws_iam_policy.cluster_autoscaler_policy.arn]

  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${module.app_cluster.oidc_provider_arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${module.app_cluster.oidc_provider}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  tags = {
    Name = "iamr-${var.environment}-cluster-autoscaler-an2",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_policy" "cluster_autoscaler_policy" {
  name = "cluster-autoscaler-an2-policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeTags",
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "ec2:DescribeLaunchTemplateVersions"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-cluster-autoscaler-an2"
  }
}

resource "aws_iam_role" "cloudwatch_fluentbit_role" {
  name = "cloudwatch-fluentbit-an2-role"

  managed_policy_arns = [aws_iam_policy.cloudwatch_fluentbit_policy.arn]

  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${module.app_cluster.oidc_provider_arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${module.app_cluster.oidc_provider}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  tags = {
    Name = "iamr-${var.environment}-cloudwatch-fluentbit-an2",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_policy" "cloudwatch_fluentbit_policy" {
  name = "cloudwatch-fluentbit-an2-policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents",
          "ec2:DescribeTags",
          "firehose:PutRecordBatch"          
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      },
      {
        "Action": [
          "es:ESHttpPost"
        ],
        "Effect": "Allow",
        "Resource": [
          "arn:aws:es:us-east-2:${data.aws_caller_identity.current.account_id}:domain/opensearch-ue2-nprd-naemo/*"
        ],
        "Sid": "opensearchAccessExcutionRole"
		  }
    ]
  })

  lifecycle {
    ignore_changes = all
  }

  tags = {
    Name = "iamp-${var.environment}-cloudwatch-fluentbit-an2",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role" "dump_collector_role" {
  name = "dump-collector-an2-role"

  managed_policy_arns = [aws_iam_policy.dump_collector_policy.arn]

  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": ["${module.app_cluster.oidc_provider_arn}",

          ]
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringEquals": {
            "${module.app_cluster.oidc_provider}:aud": "sts.amazonaws.com"
          }
        }
      }      
    ]
     Version = "2012-10-17"
    }
  )

  depends_on = [
    module.app_cluster
  ]

  tags = {
    Name = "iamr-${var.environment}-dump-collector-an2",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_policy" "dump_collector_policy" {
  name = "dump-collector-an2-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    "Statement": [
      {
         "Action": [
          "s3:ListBucket",
          "s3:DeleteObject",
          "s3:GetObject",
          "s3:PutObject",
          "s3:PutObjectAcl"],
          "Effect": "Allow",
          "Resource": [
              "arn:aws:s3:::s3-an2-${var.environment}-naemo-heap-dump",
              "arn:aws:s3:::s3-an2-${var.environment}-naemo-heap-dump/*"              
          ],
          "Sid": ""
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-dump-collector-an2",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}