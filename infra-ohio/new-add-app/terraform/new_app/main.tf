### 환경 구성 ### 
## variable.tf에서 region 및 profile을 수정해야 합니다.
## 기본 구성은 오하이오 리전에 dev 환경 입니다.


resource "aws_ecr_repository" "this" {  
  for_each = toset(var.repo_names)
  name = each.key
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "${var.environment}",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ecr_repository_policy" "this" {
  for_each = aws_ecr_repository.this
  repository =  each.value.name

  policy = jsonencode({
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "AllowPushPull",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::676826599814:role/gitlab-executor-role"
        },
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  })
  depends_on = [
    aws_ecr_repository.this
  ]
}

resource "aws_ecr_lifecycle_policy" "this" {
  for_each = aws_ecr_repository.this
  repository =  each.value.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 30 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
  depends_on = [
    aws_ecr_repository.this,
    aws_ecr_repository_policy.this
  ]
}

data "aws_iam_policy" "secret_csi_driver_policy" {
  name = "secret-csi-driver-policy"
}

data "aws_iam_policy" "external-secret-an2-policy" {
  name = "external-secret-an2-policy"
}

data "aws_iam_policy" "sqs-full-access" {
  name = "AmazonSQSFullAccess"
}

data "aws_iam_policy_document" "sqs_policy" {
    statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]
    resources = [
    "*",

    ]
 }

}

resource "aws_iam_role" "polling-middleware-role" {
  name = "polling-middleware-role"
  managed_policy_arns = [
    data.aws_iam_policy.secret_csi_driver_policy.arn,
  ]
  
  inline_policy {
    name   = "polling-middleware-policy"
    policy = data.aws_iam_policy_document.sqs_policy.json
  }

  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${var.ohio_eks_oid_app}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.ohio_eks_oid}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-polling-middleware",
    System                      = "polling-middleware",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

##

data "aws_iam_policy_document" "cognito_policy" {
    statement {
    effect = "Allow"

    actions = [
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
    "sqs:*",
    ]
    resources = [
    "*",

    ]
 }

}




resource "aws_iam_role" "be-creator-admin-role" {
  name = "be-creator-admin-role"
  managed_policy_arns = [
    data.aws_iam_policy.secret_csi_driver_policy.arn,
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AWSBatchFullAccess"
  ]
  
  inline_policy {
    name   = "be-creator-admin-policy"
    policy = data.aws_iam_policy_document.cognito_policy.json
  }

  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${var.ohio_eks_oid_app}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.ohio_eks_oid}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-be-creator-admin",
    System                      = "be-creator-admin",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "discord-middleware-role" {
  name = "discord-middleware-role"
  managed_policy_arns = [
    data.aws_iam_policy.secret_csi_driver_policy.arn,
  ]
  
  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${var.ohio_eks_oid_app}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.ohio_eks_oid}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-discord-middleware-role",
    System                      = "discord-middleware-role",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "common-middleware-role" {
  name = "common-middleware-role"
  managed_policy_arns = [
    data.aws_iam_policy.secret_csi_driver_policy.arn,
  ]
  
  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${var.ohio_eks_oid_app}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.ohio_eks_oid}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-common-middleware-role",
    System                      = "common-middleware-role",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}


resource "aws_iam_role" "polygon-middleware-role" {
  name = "polygon-middleware-role"
  managed_policy_arns = [
    data.aws_iam_policy.secret_csi_driver_policy.arn,
  ]
  
  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${var.ohio_eks_oid_app}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.ohio_eks_oid}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-polygon-middleware-role",
    System                      = "polygon-middleware-role",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "polygon-batch-role" {
  name = "polygon-batch-role"
  managed_policy_arns = [
    data.aws_iam_policy.secret_csi_driver_policy.arn,
  ]
  
  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${var.ohio_eks_oid_app}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.ohio_eks_oid}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-polygon-batch-role",
    System                      = "polygon-batch-role",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "polygon-block-confirmation-role" {
  name = "polygon-block-confirmation-role"
  managed_policy_arns = [
    data.aws_iam_policy.secret_csi_driver_policy.arn,
  ]
  
  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${var.ohio_eks_oid_app}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.ohio_eks_oid}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-polygon-block-confirmation-role",
    System                      = "polygon-block-confirmation-role",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "bc-centralwallet-polygon-role" {
  name = "bc-centralwallet-polygon-role"
  managed_policy_arns = [
    data.aws_iam_policy.external-secret-an2-policy.arn,
  ]
  
  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${var.an2_eks_oid_app}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.an2_eks_oid}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-bc-centralwallet-polygon-role",
    System                      = "bc-centralwallet-polygon-role",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}


resource "aws_iam_role" "be-openapi-role" {
  name = "be-openapi-role"
  managed_policy_arns = [
    data.aws_iam_policy.secret_csi_driver_policy.arn,
  ]
  
  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${var.ohio_eks_oid_app}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.ohio_eks_oid}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-be-openapi-role",
    System                      = "be-openapi-role",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "be-app-admin-role" {
  name = "be-app-admin-role"
  managed_policy_arns = [
    data.aws_iam_policy.secret_csi_driver_policy.arn,
  ]
  
  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${var.ohio_eks_oid_app}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.ohio_eks_oid}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-be-app-admin-role",
    System                      = "be-app-admin-role",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "be-queue-role" {
  name = "be-queue-role"
  managed_policy_arns = [
    data.aws_iam_policy.secret_csi_driver_policy.arn,
    data.aws_iam_policy.sqs-full-access.arn
  ]
  
  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${var.ohio_eks_oid_app}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.ohio_eks_oid}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-be-queue-role",
    System                      = "be-queue-role",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "be-scheduler-role" {
  name = "be-scheduler-role"
  managed_policy_arns = [
    data.aws_iam_policy.secret_csi_driver_policy.arn,
    data.aws_iam_policy.sqs-full-access.arn
  ]
  
  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${var.ohio_eks_oid_app}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.ohio_eks_oid}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-be-scheduler-role",
    System                      = "be-scheduler-role",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "be-poll-community-role" {
  name = "be-poll-community-role"
  managed_policy_arns = [
    data.aws_iam_policy.secret_csi_driver_policy.arn,
    data.aws_iam_policy.sqs-full-access.arn
  ]
  
  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${var.ohio_eks_oid_app}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.ohio_eks_oid}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-be-poll-community-role",
    System                      = "be-poll-community-role",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_iam_role" "be-reward-role" {
  name = "be-reward-role"
  managed_policy_arns = [
    data.aws_iam_policy.secret_csi_driver_policy.arn,
    data.aws_iam_policy.sqs-full-access.arn
  ]
  
  assume_role_policy = jsonencode({
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${var.ohio_eks_oid_app}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.ohio_eks_oid}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
    }
  )

  lifecycle { ignore_changes = [assume_role_policy] }

  tags = {
    Name = "iamr-${var.environment}-be-reward-role",
    System                      = "be-reward-role",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}


## secret pw 
resource "aws_secretsmanager_secret" "this" {
  for_each = toset(var.secret_names)
  name = "sm-${var.aws_shot_region}-${var.environment}-${var.service_name}-${each.key}_pw"
  kms_key_id = "${var.kms_id}"
}

resource "aws_secretsmanager_secret_version" "this" {
  for_each = aws_secretsmanager_secret.this
  secret_id     = each.value.id
  secret_string = jsonencode(var.temp)
    lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
  depends_on = [
    aws_secretsmanager_secret.this
  ]
}


## secret configure 
resource "aws_secretsmanager_secret" "this-2" {
  for_each = toset(var.secret_config)
  name = "sm-${var.aws_shot_region}-${var.environment}-${var.service_name}-${each.key}"
  kms_key_id = "${var.kms_id}"
}

resource "aws_secretsmanager_secret_version" "this-2" {
  for_each = aws_secretsmanager_secret.this-2
  secret_id     = each.value.id
  secret_string = jsonencode(var.temp)
    lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
  depends_on = [
    aws_secretsmanager_secret.this-2
  ]
}


## secret configure 
resource "aws_secretsmanager_secret" "this-3" {
  for_each = toset(var.wallet_secret_config)
  name = "sm-${var.aws_an2_shot_region}-${var.environment}-naemo-${var.wallet_service_name}-${each.key}"
  kms_key_id = "${var.kms_id}"
  provider = aws.an2
}

resource "aws_secretsmanager_secret_version" "this-3" {
  for_each = aws_secretsmanager_secret.this-3
  secret_id     = each.value.id
  secret_string = jsonencode(var.temp)
    lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
  depends_on = [
    aws_secretsmanager_secret.this-3
  ]
  provider = aws.an2
}



## SQS 
# resource "aws_sqs_queue" "notification_default_local_queue" {
#   count = var.environment == "dev" ? 1:0

#   name                      = "sqs-${var.aws_shot_region}-${var.environment}-default-notification-email-local"
#   delay_seconds             = 0
#   max_message_size          = 2048
#   message_retention_seconds = 86400
#   receive_wait_time_seconds = 0

#   sqs_managed_sse_enabled = true

#   tags = {
#     Name = "sqs-${var.aws_shot_region}-${var.environment}-default-notification-email-local",
#     System                      = "notification",
#     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
#     SupportPlatformOwnerPrimary = "BithumMeta",
#     OperationLevel              = "2"
#   }  
# }


## Redis 

# resource "aws_elasticache_replication_group" "session_service_primary-bc" {
#   replication_group_id          = var.environment == "nprd" ? "${var.environment}-${var.service_name}-rd-primary-session-service" : "${var.service_name}-redis-primary-session-service-bc"
#   description = "session-service replication group"

#   engine         = "redis"
#   engine_version = "6.x"
#   node_type      = var.session_redis_node_type
#   port           = 6379

#   multi_az_enabled = var.redis_multi_az
#   automatic_failover_enabled = var.redis_multi_az

#   replicas_per_node_group = var.cluster_mode ? 1 : null #Replicas per Shard
#   num_node_groups         = var.cluster_mode ? 1 : null #Replicas per Shar

#   num_cache_clusters =  var.cluster_mode ? null : 1

#   subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group.name
#   security_group_ids = [aws_security_group.session_service_redis_sg-bc.id, aws_security_group.management_redis_sg-bc.id]

#   kms_key_id = var.kms_redis_arn
#   at_rest_encryption_enabled = true
#   transit_encryption_enabled = true
#   auth_token = module.secret_value_session_service_redis.secret_string

#   parameter_group_name  = aws_elasticache_parameter_group.redis_session_service_param.name
#   auto_minor_version_upgrade = false

#   tags = {
#     Name = "rd-${var.aws_shot_region}-${var.environment}-${var.service_name}-primary-session-service-bc",
#     System                      = "common",
#     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
#     SupportPlatformOwnerPrimary = "BithumMeta",
#     OperationLevel              = "3"
#   }
#   depends_on = [
#     aws_security_group.session_service_redis_sg-bc,
#     aws_security_group.management_redis_sg-bc
#   ]
# }

# resource "aws_security_group" "session_service_redis_sg-bc" {
#   name        = "session-service-redis-sg-bc"
#   description = "Redis access"
#   vpc_id      = data.aws_vpc.redis_vpc.id
  

#   tags = {
#     Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-session-service-bc",
#     System                      = "common",
#     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
#     SupportPlatformOwnerPrimary = "BithumMeta",
#     OperationLevel              = "3"
#   }
# }

# resource "aws_security_group_rule" "allow_eks_inbound_session_redis-bc" {
#   type              = "ingress"
#   from_port         = 6379
#   to_port           = 6379
#   protocol          = "tcp"
#   source_security_group_id = var.eks_cluster_node_sg_id
#   description       = "6379 from eks"

#   security_group_id = aws_security_group.session_service_redis_sg-bc.id
# }

# resource "aws_ssm_parameter" "session_service_redis_endpoint" {
#   name  = "pm-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-session-service-endpoint-bc"
#   type  = "SecureString"
#   value = jsonencode({
#     "writer-endpoint": var.cluster_mode ? "${aws_elasticache_replication_group.session_service_primary-bc.configuration_endpoint_address}" : "${aws_elasticache_replication_group.session_service_primary-bc.primary_endpoint_address}",
#     "reader-endpoint": "${aws_elasticache_replication_group.session_service_primary-bc.reader_endpoint_address}"
#   })
# }

