locals {
  gitlab_runner_image_list = fileset("${path.module}/../images/gitlab", "*/Dockerfile")
  k8s_image_list = fileset("${path.module}/../images/k8s", "**/Dockerfile")
  app_image_list = fileset("${path.module}/../images/app", "*/Dockerfile")
}

resource "aws_ecr_repository" "gitlab-runner-image" {
  for_each = local.gitlab_runner_image_list
  
  name                 = dirname(each.value)
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

resource "aws_ecr_repository" "k8s-image" {
  for_each = local.k8s_image_list
  
  name                 = dirname(each.value)
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

resource "aws_ecr_repository" "app-image" {
  for_each = local.app_image_list
  
  name                 = dirname(each.value)
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

resource "aws_ecr_repository_policy" "k8s_image_policy" {
  for_each = local.k8s_image_list

  repository = aws_ecr_repository.k8s-image[each.value].name

  policy = jsonencode({
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "AllowPull",
        "Effect": "Allow",
        "Principal": {
          "AWS": [
            "arn:aws:iam::385866877617:root",
            "arn:aws:iam::087942668956:root",
            "arn:aws:iam::908317417455:root"  
          ]
        },
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
      }
    ]
  })
}

resource "aws_ecr_repository_policy" "app_image_policy" {
  for_each = local.app_image_list

  repository = aws_ecr_repository.app-image[each.value].name

  policy = jsonencode({
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "AllowPull",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::385866877617:root"
        },
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
      }
    ]
  })
}
