resource "aws_iam_role" "dev_roles" {
  for_each = var.dev_roles

  provider  = aws.dev

  name = each.value.name
  managed_policy_arns = each.value.policys
  max_session_duration = 43200

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "${each.value.trust}"
        },
        "Action": "sts:AssumeRole",
        "Condition": {}
      }
    ]
	})
}

resource "aws_iam_role" "stg_roles" {
  for_each = var.stg_roles

  provider  = aws.stg

  name = each.value.name
  managed_policy_arns = each.value.policys
  max_session_duration = 43200

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "${each.value.trust}"
        },
        "Action": "sts:AssumeRole",
        "Condition": {}
      }
    ]
	})
}

resource "aws_iam_role" "prd_roles" {
  for_each = var.prd_roles

  provider  = aws.prd

  name = each.value.name
  managed_policy_arns = each.value.policys
  max_session_duration = 43200

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "${each.value.trust}"
        },
        "Action": "sts:AssumeRole",
        "Condition": {}
      }
    ]
	})
}

resource "aws_iam_role" "net_roles" {
  for_each = var.net_roles

  provider  = aws.net

  name = each.value.name
  managed_policy_arns = each.value.policys
  max_session_duration = 43200

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "${each.value.trust}"
        },
        "Action": "sts:AssumeRole",
        "Condition": {}
      }
    ]
	})
}

resource "aws_iam_role" "bmeta_dev_roles" {
  for_each = var.bmeta_dev_roles

  provider  = aws.dev

  name = each.value.name
  managed_policy_arns = each.value.policys
  max_session_duration = 43200

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "${each.value.trust}"
        },
        "Action": "sts:AssumeRole",
        "Condition": {}
      }
    ]
	})
}

## ssm read only policy 

resource "aws_iam_policy" "dev_ssm_readonly_policy" {
  provider  = aws.dev

  name = "ssm-readonly-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds",
          "secretsmanager:ListSecrets"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-ssm-readonly-policy"
  }
}

resource "aws_iam_policy" "stg_ssm_readonly_policy" {
  provider  = aws.stg

  name = "ssm-readonly-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds",
          "secretsmanager:ListSecrets"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-ssm-readonly-policy"
  }
}

resource "aws_iam_policy" "prd_ssm_readonly_policy" {
  provider  = aws.prd

  name = "ssm-readonly-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds",
          "secretsmanager:ListSecrets"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = {
    Name = "iamp-${var.environment}-ssm-readonly-policy"
  }
}
