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
    System                      = "dev-new",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_ecr_repository_policy" "this" {
  for_each = aws_ecr_repository.this
  repository =  each.key

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
  for_each                  = aws_ecr_repository.this
  repository                =  each.key

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
