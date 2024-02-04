resource "aws_iam_role" "be_centralwallet_role" {
  name = "be-centralwallet-role"

  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess",
                        aws_iam_policy.be_centralwallet_policy.arn,
                        aws_iam_policy.external_secret_policy.arn]

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

  tags = {
    Name = "iamr-${var.environment}-be-centralwallet",
    System                      = "centralwallet",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_iam_policy" "be_centralwallet_policy" {
  name = "be-centralwallet-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow",
        "Action": [
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
        "Resource": [
          "*"
        ]
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-be-centralwallet",
    System                      = "centralwallet",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_iam_role" "bc_centralwallet_role" {
  name = "bc-centralwallet-role"

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

  tags = {
    Name = "iamr-${var.environment}-bc-centralwallet",
    System                      = "centralwallet",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_iam_role" "fe_centralwallet_role" {
  name = "fe-centralwallet-role"

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

  tags = {
    Name = "iamr-${var.environment}-fe-centralwallet",
    System                      = "centralwallet",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}
