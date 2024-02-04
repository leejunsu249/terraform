resource "aws_ecr_repository" "be_notification_next_image" {
  count = var.environment == "dev" ? 1 : 0

  name                 = "${var.notification_ecr_name}-next"
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

resource "aws_ecr_repository_policy" "be_notification_next_image_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.be_notification_next_image[0].name

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

resource "aws_ecr_lifecycle_policy" "be_notification_next_lifecycle_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.be_notification_next_image[0].name

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

resource "aws_ecr_repository" "be_systemadmin_next_image" {
  count = var.environment == "dev" ? 1 : 0

  name                 = "${var.systemadmin_be_ecr_name}-next"
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "systemadmin",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_ecr_repository_policy" "be_systemadmin_next_image_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.be_systemadmin_next_image[0].name

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

resource "aws_ecr_lifecycle_policy" "be_systemadmin_next_lifecycle_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.be_systemadmin_next_image[0].name

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

resource "aws_ecr_repository" "fe_systemadmin_next_image" {
  count = var.environment == "dev" ? 1 : 0

  name                 = "${var.systemadmin_fe_ecr_name}-next"
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

resource "aws_ecr_repository_policy" "fe_systemadmin_next_image_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.fe_systemadmin_next_image[0].name

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

resource "aws_ecr_lifecycle_policy" "fe_systemadmin_next_lifecycle_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.fe_systemadmin_next_image[0].name

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

resource "aws_ecr_repository" "be_launchpadruntime_next_image" {
  count = var.environment == "dev" ? 1 : 0
  
  name                 = "${var.launchpadruntime_ecr_name}-next"
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

resource "aws_ecr_repository_policy" "be_launchpadruntime_next_image_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.be_launchpadruntime_next_image[0].name

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

resource "aws_ecr_lifecycle_policy" "be_launchpadruntime_next_lifecycle_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.be_launchpadruntime_next_image[0].name

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

resource "aws_ecr_repository" "be_metaverse_next_image" {
  count = var.environment == "dev" ? 1 : 0

  name                 = "${var.metaverse_ecr_name}-next"
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
      encryption_type = "KMS"
  }

  tags = {
    System                      = "metaverse",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_ecr_repository_policy" "be_metaverse_next_image_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.be_metaverse_next_image[0].name

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

resource "aws_ecr_lifecycle_policy" "be_metaverse_next_lifecycle_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.be_metaverse_next_image[0].name

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

resource "aws_ecr_repository" "eth_middleware_next_image" {
  count = var.environment == "dev" ? 1 : 0

  name                 = "${var.eth_middleware_ecr_name}-next"
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

resource "aws_ecr_repository_policy" "eth_middleware_next_image_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.eth_middleware_next_image[0].name

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

resource "aws_ecr_lifecycle_policy" "eth_middleware_next_lifecycle_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.eth_middleware_next_image[0].name

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

resource "aws_ecr_repository" "eth_batch_next_image" {
  count = var.environment == "dev" ? 1 : 0

  name                 = "${var.eth_batch_ecr_name}-next"
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

resource "aws_ecr_repository_policy" "eth_batch_next_image_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.eth_batch_next_image[0].name

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

resource "aws_ecr_lifecycle_policy" "eth_batch_next_lifecycle_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.eth_batch_next_image[0].name

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

resource "aws_ecr_repository" "be_marketplace_next_image" {
  count = var.environment == "dev" ? 1 : 0

  name                 = "${var.marketplace_ecr_name}-next"
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

resource "aws_ecr_repository_policy" "be_marketplace_next_image_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.be_marketplace_next_image[0].name

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

resource "aws_ecr_lifecycle_policy" "be_marketplace_next_lifecycle_policy" {
  count = var.environment == "dev" ? 1 : 0

  repository = aws_ecr_repository.be_marketplace_next_image[0].name

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