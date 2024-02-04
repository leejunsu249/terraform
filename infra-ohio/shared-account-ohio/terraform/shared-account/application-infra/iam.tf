resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2_role.name
  tags = {
    Name = "iami-${var.environment}-ec2"
  }
}
resource "aws_iam_role" "ec2_role" {
  name = "ec2-role"

  managed_policy_arns = [
    aws_iam_policy.ec2_policy.arn,
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"]

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    Name = "iamr-${var.environment}-ec2"
  }
}

resource "aws_iam_policy" "ec2_policy" {
  name = "ec2-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:DescribeTags"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-ec2"
  }
}

resource "aws_iam_instance_profile" "gitlab_profile" {
  name = "gitlab-ee-profile"
  role = aws_iam_role.gitlab_repository_role.name

  tags = {
    Name = "iami-${var.environment}-gitlab-ee"
  }  
}

resource "aws_iam_role" "gitlab_repository_role" {
  name = "gitlab-ee-role"

  managed_policy_arns = [
                          aws_iam_policy.allow_gitlab_policy.arn, 
                          aws_iam_policy.ec2_policy.arn,
                          "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
                          "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
                          "arn:aws:iam::676826599814:policy/admins"
                        ]

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  })

  tags = {
    Name = "iamr-${var.environment}-gitlab-ee"
  }  
}

resource "aws_iam_policy" "allow_gitlab_policy" {
  name = "gitlab-ee-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid": "gitlabPolicy",
        "Effect": "Allow",
        "Action": [
          "s3:PutObjectAcl",
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ],
        "Resource": [
                      "${aws_s3_bucket.gitlab_artifact.arn}",
                      "${aws_s3_bucket.gitlab_artifact.arn}/*",
                      "${aws_s3_bucket.gitlab_cache.arn}",
                      "${aws_s3_bucket.gitlab_cache.arn}/*",
                      "${aws_s3_bucket.gitlab_backup.arn}",
                      "${aws_s3_bucket.gitlab_backup.arn}/*",
                      "${aws_s3_bucket.gitlab_bc_artifact.arn}",
                      "${aws_s3_bucket.gitlab_bc_artifact.arn}/*",
                      "${aws_s3_bucket.gitlab_bc_cache.arn}",
                      "${aws_s3_bucket.gitlab_bc_cache.arn}/*",
                      "${aws_s3_bucket.gitlab_bc_backup.arn}",
                      "${aws_s3_bucket.gitlab_bc_backup.arn}/*"
                    ]
      },
      {
        "Sid": "gitlabPolicyEKS",
        "Effect": "Allow",
        "Action": [
          "eks:ListClusters",
          "eks:DescribeAddonVersions",
          "eks:DescribeCluster"
        ],
        "Resource": "*"
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-gitlab"
  }  
}

resource "aws_iam_role" "gitlab_runner_cluster_role" {
  name = "gitlab-runner-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }  
    ]
  })

  tags = {
    Name = "iamr-${var.environment}-gitlab-runner"
  }  
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.gitlab_runner_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.gitlab_runner_cluster_role.name
}

resource "aws_iam_role" "fargate_role" {
  name = "gitlab-executor-role"

  managed_policy_arns = [aws_iam_policy.allow_assume_application_account_policy.arn, 
                        "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy", 
                        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser", 
                        "arn:aws:iam::aws:policy/AdministratorAccess"
                        ]

  assume_role_policy = jsonencode({
    Statement = [{
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks-fargate-pods.amazonaws.com"
        }
      },
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "${module.gitlab_runner_cluster.oidc_provider_arn}"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringEquals": {
            "${module.gitlab_runner_cluster.oidc_provider}:aud": "sts.amazonaws.com"
          }
        }
      }]
      Version = "2012-10-17"
    }
  )

  tags = {
    Name = "iamr-${var.environment}-gitlab-executor"
  }  
}

resource "aws_iam_policy" "allow_assume_application_account_policy" {
  name = "allow-assume-application-account-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Resource = [
          "arn:aws:iam::${var.dev_account.number}:role/${var.dev_account.role}",
          "arn:aws:iam::${var.stg_account.number}:role/${var.stg_account.role}",
          "arn:aws:iam::${var.prd_account.number}:role/${var.prd_account.role}",
          "arn:aws:iam::${var.net_account.number}:role/${var.net_account.role}",
        ]
      }
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-gitlab"
  }  
}
