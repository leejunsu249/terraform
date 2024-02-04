resource "aws_iam_role" "be_marketplace_role" {
  name = "be-marketplace-role"

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    aws_iam_policy.be_marketplace_policy.arn,
    aws_iam_policy.secret_csi_driver_policy.arn,
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
  ]

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

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-be-marketplace",
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_policy" "be_marketplace_policy" {
  name = "be-marketplace-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "batch:SubmitJob",
          "cognito-idp:DescribeUserPool",
          "cognito-idp:CreateUserPoolClient",
          "cognito-idp:DeleteUserPoolClient",
          "cognito-idp:UpdateUserPoolClient",
          "cognito-idp:DescribeUserPoolClient",
          "cognito-idp:AdminInitiateAuth",
          "cognito-idp:AdminUserGlobalSignOut",
          "cognito-idp:ListUserPoolClients",
          "cognito-idp:AdminCreateUser",
          "cognito-idp:AdminSetUserPassword",
          "cognito-idp:AdminDeleteUser",
          "sqs:*"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-be-marketplace",
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "be_systemadmin_role" {
  name = "be-systemadmin-role"

  managed_policy_arns = [
    aws_iam_policy.be_systemadmin_policy.arn,
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    aws_iam_policy.secret_csi_driver_policy.arn
  ]

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

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-be-systemadmin",
    System                      = "systemadmin",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_policy" "be_systemadmin_policy" {
  name = "be-systemadmin-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "cognito-idp:DescribeUserPool",
          "cognito-idp:CreateUserPoolClient",
          "cognito-idp:DeleteUserPoolClient",
          "cognito-idp:UpdateUserPoolClient",
          "cognito-idp:DescribeUserPoolClient",
          "cognito-idp:AdminInitiateAuth",
          "cognito-idp:AdminUserGlobalSignOut",
          "cognito-idp:ListUserPoolClients",
          "cognito-idp:AdminCreateUser",
          "cognito-idp:AdminSetUserPassword",
          "batch:SubmitJob"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-be-systemadmin",
    System                      = "systemadmin",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "be_notification_role" {
  name = "be-notification-role"

  managed_policy_arns = [aws_iam_policy.ses_send_policy.arn,
    aws_iam_policy.be_notification_policy.arn,
    aws_iam_policy.secret_csi_driver_policy.arn
  ]

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

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-be-notification",
    System                      = "notification",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_policy" "be_notification_policy" {
  name = "be-notification-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "cloudformation:DescribeStackResources",
          "sqs:*"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-be-notification",
    System                      = "notification",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "be_launchpadruntime_role" {
  name = "be-launchpadruntime-role"

  managed_policy_arns = [
    aws_iam_policy.be_launchpadruntime_policy.arn,
    aws_iam_policy.secret_csi_driver_policy.arn,
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
  ]

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

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-be-launchpad",
    System                      = "launchpad",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_policy" "be_launchpadruntime_policy" {
  name = "be-launchpadruntime-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "cognito-idp:DescribeUserPool",
          "cognito-idp:CreateUserPoolClient",
          "cognito-idp:DeleteUserPoolClient",
          "cognito-idp:UpdateUserPoolClient",
          "cognito-idp:DescribeUserPoolClient",
          "cognito-idp:AdminInitiateAuth",
          "cognito-idp:AdminUserGlobalSignOut",
          "cognito-idp:ListUserPoolClients",
          "cognito-idp:AdminCreateUser",
          "cognito-idp:AdminSetUserPassword"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-be-launchpadruntime",
    System                      = "launchpad",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_policy" "secret_csi_driver_policy" {
  name = "secret-csi-driver-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "ssm:GetParameterHistory",
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:DescribeParameters",
          "ssm:GetParametersByPath",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "kms:GetPublicKey",
          "kms:Decrypt",
          "kms:ListKeyPolicies",
          "kms:ListRetirableGrants",
          "kms:GetKeyPolicy",
          "kms:ListResourceTags",
          "kms:ListGrants",
          "kms:GetParametersForImport",
          "kms:DescribeCustomKeyStores",
          "kms:ListKeys",
          "kms:GetKeyRotationStatus",
          "kms:Encrypt",
          "kms:ListAliases",
          "kms:DescribeKey"
        ],
        "Resource" : "*"
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-secret-csi-driver-policy",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role" "eth_middleware_role" {
  name = "eth-middleware-role"

  managed_policy_arns = [
    aws_iam_policy.secret_csi_driver_policy.arn
  ]

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

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-eth-middleware",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "eth_batch_role" {
  name = "eth-batch-role"

  managed_policy_arns = [
    aws_iam_policy.secret_csi_driver_policy.arn
  ]

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

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-eth-batch",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "eth_block_confirmation_role" {
  name = "eth-block-confirmation-role"

  managed_policy_arns = [
    aws_iam_policy.secret_csi_driver_policy.arn
  ]

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
    Name = "iamr-${var.environment}-eth-block-confirmation",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "sol_middleware_role" {
  name = "sol-middleware-role"

  managed_policy_arns = [
    aws_iam_policy.secret_csi_driver_policy.arn
  ]

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
    Name = "iamr-${var.environment}-sol-middleware",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "sol_batch_role" {
  name = "sol-batch-role"

  managed_policy_arns = [
    aws_iam_policy.secret_csi_driver_policy.arn
  ]

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
    Name = "iamr-${var.environment}-sol-batch",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "sol_block_confirmation_role" {
  name = "sol-block-confirmation-role"

  managed_policy_arns = [
    aws_iam_policy.secret_csi_driver_policy.arn
  ]

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
    Name = "iamr-${var.environment}-sol-block-confirmation",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "be_kafka_role" {
  name = "be-kafka-role"

  managed_policy_arns = [aws_iam_policy.be_kafka_policy.arn]

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
    Name = "iamr-${var.environment}-be-kafka",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_policy" "be_kafka_policy" {
  name = "be-kafka-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "glue:GetRegistry",
          "glue:ListRegistries",
          "glue:GetSchema",
          "glue:ListSchemas",
          "glue:GetSchemaByDefinition",
          "glue:GetSchemaVersion",
          "glue:ListSchemaVersions",
          "glue:GetSchemaVersionsDiff",
          "glue:CheckSchemaVersionValidity",
          "glue:QuerySchemaVersionMetadata",
          "glue:GetTags",
          "sqs:*"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-be-kafka",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}
