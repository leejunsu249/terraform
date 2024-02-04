resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2_role.name

  tags = {
    Name = "iami-${var.environment}-ec2",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2-role"

  managed_policy_arns = [aws_iam_policy.ec2_policy.arn, 
  "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", 
  "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
  "arn:aws:iam::908317417455:policy/ec2-kinesis-policy"]

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
    Name = "iamr-${var.environment}-ec2",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }

  lifecycle {
    ignore_changes = [managed_policy_arns]
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
    Name = "iamp-${var.environment}-ec2",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}
