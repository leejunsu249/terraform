resource "aws_iam_role" "authenticated" {
  name = "${var.cognito_name}-auth-role"

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
    Name = "iamr-${var.aws_shot_region}-${var.environment}-${var.service_name}-${var.cognito_name}-auth",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role_policy" "authenticated" {
  name = "${var.cognito_name}-auth-policy"
  role = aws_iam_role.authenticated.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow",
        "Action": [
          "mobileanalytics:PutEvents",
          "cognito-sync:*"
        ],
        "Resource": [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "unauthenticated" {
  name = "${var.cognito_name}-unauth-role"

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
            "cognito-identity.amazonaws.com:amr": "unauthenticated"
          }
        }
      }
    ]
  })

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.aws_shot_region}-${var.environment}-${var.service_name}-${var.cognito_name}-unauth",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role_policy" "unauthenticated" {
  name = "${var.cognito_name}-unauth-policy"
  role = aws_iam_role.unauthenticated.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow",
        "Action": [
            "mobileanalytics:PutEvents",
            "cognito-sync:*"
        ],
        "Resource": [
            "*"
        ]
      }
    ]
  })
}

resource "aws_cognito_identity_pool_roles_attachment" "identity_pool" {
  identity_pool_id = aws_cognito_identity_pool.identity_pool.id
  
  roles = {
    "authenticated" = aws_iam_role.authenticated.arn
    "unauthenticated" = aws_iam_role.unauthenticated.arn
  }

  role_mapping {
    ambiguous_role_resolution = "Deny"
    identity_provider = "cognito-idp.us-east-2.amazonaws.com/${aws_cognito_user_pool.user_pool.id}:${data.aws_cognito_user_pool_clients.user_pool_client.client_ids[0]}"
    type = "Token"
  }

  depends_on = [
    aws_cognito_user_pool.user_pool,
    aws_elasticsearch_domain.opensearch
  ]
}

data "aws_cognito_user_pool_clients" "user_pool_client" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
}