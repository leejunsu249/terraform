resource "aws_iam_role" "external_dns_role" {
  name = "external-dns-role"

  managed_policy_arns = [aws_iam_policy.external_dns_policy.arn]

  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "${module.app_cluster.oidc_provider_arn}"
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

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-external-dns",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_policy" "external_dns_policy" {
  name = "external-dns-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow",
        "Action": [
          "route53:ChangeResourceRecordSets"
        ],
        "Resource": [
          "arn:aws:route53:::hostedzone/*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets"
        ],
        "Resource": [
          "*"
        ]
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-external-dns",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role" "external_secret_role" {
  name = "external-secret-role"

  managed_policy_arns = [aws_iam_policy.external_secret_policy.arn]

  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "${module.app_cluster.oidc_provider_arn}"
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

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-external-secret",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_policy" "external_secret_policy" {
  name = "external-secret-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
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
        "Resource": "*"
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-external-secret",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_policy" "ses_send_policy" {
  name = "ses-send-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action":[
          "ses:SendEmail",
          "ses:SendRawEmail",
          "sns:Publish"
        ],
        "Resource":"*"
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-ses-send",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role" "cluster_autoscaler_role" {
  name = "cluster-autoscaler-role"

  managed_policy_arns = [aws_iam_policy.cluster_autoscaler_policy.arn]

  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "${module.app_cluster.oidc_provider_arn}"
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

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-cluster-autoscaler",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_policy" "cluster_autoscaler_policy" {
  name = "cluster-autoscaler-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:DescribeLaunchTemplateVersions"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-cluster-autoscaler",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role" "cloudwatch_fluentbit_role" {
  name = "cloudwatch-fluentbit-role"

  managed_policy_arns = [aws_iam_policy.cloudwatch_fluentbit_policy.arn]

  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "${module.app_cluster.oidc_provider_arn}"
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

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-cloudwatch-fluentbit",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_policy" "cloudwatch_fluentbit_policy" {
  name = "cloudwatch-fluentbit-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
          "Action": [
            "logs:CreateLogStream",
            "logs:CreateLogGroup",
            "logs:DescribeLogStreams",
            "logs:PutLogEvents",
            "ec2:DescribeTags",
            "firehose:PutRecordBatch"
          ],
          "Resource": "*",
          "Effect": "Allow"
      },
      {
        "Sid": "opensearchAccessExcutionRole",
        "Effect": "Allow",
        "Action": [
          "es:ESHttpPost"
        ],
        "Resource": [
          "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/opensearch-ue2-prd-naemo/*",
          "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/opensearch-ue2-nprd-naemo/*"
        ]
      },      
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-cloudwatch-fluentbit",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role" "argocd_an2_role" {
  name = "argocd-an2-role"

  assume_role_policy = jsonencode({
    Statement = [
      {
          "Effect": "Allow",
          "Principal": {
              "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/argocd-role"
          },
          "Action": "sts:AssumeRole",
          "Condition": {}
      }
      ]
      Version = "2012-10-17"
    }
  )

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-argocd-an2",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role" "argocd_role" {
  name = "argocd-role"

  managed_policy_arns = [aws_iam_policy.argocd_policy.arn]

  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "${module.app_cluster.oidc_provider_arn}"
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

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-argocd",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }


  depends_on = [aws_iam_role.argocd_an2_role]
}

resource "aws_iam_policy" "argocd_policy" {
  name = "argocd-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
          "Action": "sts:AssumeRole",
          "Effect": "Allow",
          "Resource": [
              "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/argocd-an2-role"
          ],
          "Sid": ""
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-argocd",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role" "nginx_ingress_role" {
  name = "nginx-ingress-role"

  managed_policy_arns = [aws_iam_policy.nginx_ingress_policy.arn]

  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "${module.app_cluster.oidc_provider_arn}"
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

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-nginx-ingress",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }


  depends_on = [aws_iam_policy.nginx_ingress_policy]
}

resource "aws_iam_policy" "nginx_ingress_policy" {
  name = "nginx-ingress-policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
         "Action": ["s3:GetBucketAcl", "s3:PutObject"],
          "Effect": "Allow",
          "Resource": [
              "arn:aws:s3:::s3-ue2-shd-elb-logs",
              "arn:aws:s3:::s3-ue2-shd-elb-logs/*"
          ],
          "Sid": ""
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-nginx-ingress",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role" "dump_collector_role" {
  name = "dump-collector-role"

  managed_policy_arns = [aws_iam_policy.dump_collector_policy.arn]

  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "${module.app_cluster.oidc_provider_arn}"
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

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-dump-collector",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_policy" "dump_collector_policy" {
  name = "dump-collector-policy"

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
            "arn:aws:s3:::s3-ue2-${var.environment}-naemo-heap-dump",
            "arn:aws:s3:::s3-ue2-${var.environment}-naemo-heap-dump/*"            
          ],
          "Sid": ""
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-dump-collector",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}