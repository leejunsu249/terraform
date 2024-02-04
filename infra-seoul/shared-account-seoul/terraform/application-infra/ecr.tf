resource "aws_ecr_repository" "gitlab-runner-kaniko" {
  name                 = "gitlab-runner-image-kaniko"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

  encryption_configuration {
    encryption_type = "KMS"
  }

	tags = {
		Name = "ecr-${var.aws_shot_region}-${var.environment}-${var.service_name}-gitlab-runner-image-kaniko"
		Lang = "kaniko",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
	}
}

resource "aws_ecr_repository" "gitlab-runner-aws-sdk" {
  name                 = "gitlab-runner-image-aws-sdk"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

  encryption_configuration {
    encryption_type = "KMS"
  }

	tags = {
		Name = "ecr-${var.aws_shot_region}-${var.environment}-${var.service_name}-gitlab-runner-image-aws-sdk"
		Lang = "aws-sdk",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
	}
}