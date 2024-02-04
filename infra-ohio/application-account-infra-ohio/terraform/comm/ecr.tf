resource "aws_ecr_repository" "be_notification_image" {
  name                 = var.notification_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "notification",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_ecr_repository_policy" "be_notification_image_policy" {
  repository = aws_ecr_repository.be_notification_image.name

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
}

resource "aws_ecr_lifecycle_policy" "be_notification_lifecycle_policy" {
  repository = aws_ecr_repository.be_notification_image.name

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
}

resource "aws_ecr_repository" "be_marketplace_image" {
  name                 = var.marketplace_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_ecr_repository_policy" "be_marketplace_image_policy" {
  repository = aws_ecr_repository.be_marketplace_image.name

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
}

resource "aws_ecr_lifecycle_policy" "be_marketplace_lifecycle_policy" {
  repository = aws_ecr_repository.be_marketplace_image.name

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
}

resource "aws_ecr_repository" "be_systemadmin_image" {
  name                 = var.systemadmin_be_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "backoffice",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_ecr_repository_policy" "be_systemadmin_image_policy" {
  repository = aws_ecr_repository.be_systemadmin_image.name

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
}

resource "aws_ecr_lifecycle_policy" "be_systemadmin_lifecycle_policy" {
  repository = aws_ecr_repository.be_systemadmin_image.name

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
}

resource "aws_ecr_repository" "fe_systemadmin_image" {
  name                 = var.systemadmin_fe_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "backoffice",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_ecr_repository_policy" "fe_systemadmin_image_policy" {
  repository = aws_ecr_repository.fe_systemadmin_image.name

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
}

resource "aws_ecr_lifecycle_policy" "fe_systemadmin_lifecycle_policy" {
  repository = aws_ecr_repository.fe_systemadmin_image.name

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
}

resource "aws_ecr_repository" "fe_centralwallet_image" {  
  name                 = var.centralwallet_fe_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "centralwallet",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ecr_repository_policy" "fe_centralwallet_image_policy" {
  repository = aws_ecr_repository.fe_centralwallet_image.name

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
}

resource "aws_ecr_lifecycle_policy" "fe_centralwallet_lifecycle_policy" {
  repository = aws_ecr_repository.fe_centralwallet_image.name

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
}

resource "aws_ecr_repository" "be_centralwallet_image" {
  name                 = var.centralwallet_be_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "centralwallet",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ecr_repository_policy" "be_centralwallet_image_policy" {
  repository = aws_ecr_repository.be_centralwallet_image.name

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
}

resource "aws_ecr_lifecycle_policy" "be_centralwallet_lifecycle_policy" {
  repository = aws_ecr_repository.be_centralwallet_image.name

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
}

resource "aws_ecr_repository" "feature_image" {
  count = var.environment == "dev" ? 1 : 0

  name                 = var.feature_ecr_name
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_ecr_repository_policy" "feature_image_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.feature_image[0].name

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
}

resource "aws_ecr_lifecycle_policy" "feature_image_lifecycle_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.feature_image[0].name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 3 days",
            "selection": {
                "tagStatus": "any",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 3
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

resource "aws_ecr_repository" "be_launchpadruntime_image" {
  name                 = var.launchpadruntime_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "launchpad",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_ecr_repository_policy" "be_launchpadruntime_image_policy" {
  repository = aws_ecr_repository.be_launchpadruntime_image.name

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
}

resource "aws_ecr_lifecycle_policy" "be_launchpadruntime_lifecycle_policy" {
  repository = aws_ecr_repository.be_launchpadruntime_image.name

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
}

resource "aws_ecr_repository" "be_metaverse_image" {
  name                 = var.metaverse_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }
}

resource "aws_ecr_repository_policy" "be_metaverse_image_policy" {
  repository = aws_ecr_repository.be_metaverse_image.name

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
}

resource "aws_ecr_lifecycle_policy" "be_metaverse_lifecycle_policy" {
  repository = aws_ecr_repository.be_metaverse_image.name

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
}

resource "aws_ecr_repository" "eth_middleware_image" {
  name                 = var.eth_middleware_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_ecr_repository_policy" "eth_middleware_image_policy" {
  repository = aws_ecr_repository.eth_middleware_image.name

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
}

resource "aws_ecr_lifecycle_policy" "eth_middleware_lifecycle_policy" {
  repository = aws_ecr_repository.eth_middleware_image.name

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
}

resource "aws_ecr_repository" "eth_batch_image" {
  name                 = var.eth_batch_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_ecr_repository_policy" "eth_batch_image_policy" {
  repository = aws_ecr_repository.eth_batch_image.name

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
}

resource "aws_ecr_lifecycle_policy" "eth_batch_lifecycle_policy" {
  repository = aws_ecr_repository.eth_batch_image.name

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
}

resource "aws_ecr_repository" "eth_block_confirmation_image" {
  name                 = var.eth_block_confirmation_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_ecr_repository_policy" "eth_block_confirmation_image_policy" {
  repository = aws_ecr_repository.eth_block_confirmation_image.name

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
}

resource "aws_ecr_lifecycle_policy" "eth_block_confirmation_lifecycle_policy" {
  repository = aws_ecr_repository.eth_block_confirmation_image.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 10 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

resource "aws_ecr_repository" "sol_middleware_image" {
  name                 = var.sol_middleware_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_ecr_repository_policy" "sol_middleware_image_policy" {
  repository = aws_ecr_repository.sol_middleware_image.name

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
}

resource "aws_ecr_lifecycle_policy" "sol_middleware_lifecycle_policy" {
  repository = aws_ecr_repository.sol_middleware_image.name

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
}

resource "aws_ecr_repository" "sol_batch_image" {
  name                 = var.sol_batch_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_ecr_repository_policy" "sol_batch_image_policy" {
  repository = aws_ecr_repository.sol_batch_image.name

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
}

resource "aws_ecr_lifecycle_policy" "sol_batch_lifecycle_policy" {
  repository = aws_ecr_repository.sol_batch_image.name

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
}

resource "aws_ecr_repository" "sol_block_confirmation_image" {
  name                 = var.sol_block_confirmation_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_ecr_repository_policy" "sol_block_confirmation_image_policy" {
  repository = aws_ecr_repository.sol_block_confirmation_image.name

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
}

resource "aws_ecr_lifecycle_policy" "sol_block_confirmation_lifecycle_policy" {
  repository = aws_ecr_repository.sol_block_confirmation_image.name

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
}

resource "aws_ecr_repository" "bc_centralwallet_image" {
  name                 = var.bc_centralwallet_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "centralwallet",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ecr_repository_policy" "bc_centralwallet_image_policy" {
  repository = aws_ecr_repository.bc_centralwallet_image.name

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
}

resource "aws_ecr_lifecycle_policy" "bc_centralwallet_lifecycle_policy" {
  repository = aws_ecr_repository.bc_centralwallet_image.name

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
}

resource "aws_ecr_repository" "blockchain_cache_image" {
  name                 = var.blockchain_cache_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_ecr_repository_policy" "blockchain_cache_image_policy" {
  repository = aws_ecr_repository.blockchain_cache_image.name

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
}

resource "aws_ecr_lifecycle_policy" "blockchain_cache_lifecycle_policy" {
  repository = aws_ecr_repository.blockchain_cache_image.name

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
}

resource "aws_ecr_repository" "be_kafka_image" {
  name                 = var.kafka_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_ecr_repository_policy" "be_kafka_image_policy" {
  repository = aws_ecr_repository.be_kafka_image.name

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
}

resource "aws_ecr_lifecycle_policy" "be_kafka_lifecycle_policy" {
  repository = aws_ecr_repository.be_kafka_image.name

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
}


resource "aws_ecr_repository" "be_search_image" {
  name                 = var.search_ecr_name
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_ecr_repository_policy" "be_search_image_policy" {
  repository = aws_ecr_repository.be_search_image.name

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
}

resource "aws_ecr_lifecycle_policy" "be_search_lifecycle_policy" {
  repository = aws_ecr_repository.be_search_image.name

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
}





