### eks-working-prd ####
resource "aws_instance" "eks_working_prd" {
  ami           = var.common_os_ami
  instance_type = var.eks_working_instance_type

  iam_instance_profile = aws_iam_instance_profile.gitlab_profile.id

  vpc_security_group_ids = [aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.node_subnets[1]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = file("scripts/user-data.sh")
  disable_api_termination = true
  lifecycle { ignore_changes = [user_data] }

  root_block_device {
    volume_type = "gp3"
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-eks-working-prd-naemo",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-eks-working-prd-naemo",
    Hiware = "True",
    OS_info  = "AWS LINUX AMI 2",
    DEV_GRP  = "bmeta/management/prd",
    Protocol = "SSH_22|SFTP_22",
    Backup   = "True",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

### eks-working-prd-wallet ####
resource "aws_instance" "eks_working_prd_wallet" {
  ami           = var.common_os_ami
  instance_type = var.eks_working_instance_type

  iam_instance_profile = aws_iam_instance_profile.gitlab_profile.id

  vpc_security_group_ids = [aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.node_subnets[1]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = file("scripts/user-data.sh")
  disable_api_termination = true
  lifecycle { ignore_changes = [user_data] }

  root_block_device {
    volume_type = "gp3"
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-eks-working-prd-wallet",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-eks-working-prd-wallet",
    Hiware = "True",
    OS_info  = "AWS LINUX AMI 2",
    DEV_GRP  = "bmeta/management/prd",
    Protocol = "SSH_22|SFTP_22",
    Backup   = "True",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

### eks-working-dev ####
resource "aws_instance" "eks_working_dev" {
  ami           = var.common_os_ami
  instance_type = var.eks_working_instance_type

  iam_instance_profile = aws_iam_instance_profile.gitlab_profile.id

  vpc_security_group_ids = [aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.node_subnets[1]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = file("scripts/user-data.sh")
  disable_api_termination = true
  lifecycle { ignore_changes = [user_data] }

  root_block_device {
    volume_type = "gp3"
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-eks-working-dev-naemo",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-eks-working-dev-naemo",
    Hiware = "True",
    OS_info  = "AWS LINUX AMI 2",
    DEV_GRP  = "bmeta/management/dev",
    Protocol = "SSH_22|SFTP_22",
    Backup   = "True",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

### eks-working-dev-wallet ####
resource "aws_instance" "eks_working_dev_wallet" {
  ami           = var.common_os_ami
  instance_type = var.eks_working_instance_type

  iam_instance_profile = aws_iam_instance_profile.gitlab_profile.id

  vpc_security_group_ids = [aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.node_subnets[1]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = file("scripts/user-data.sh")
  disable_api_termination = true
  lifecycle { ignore_changes = [user_data] }

  root_block_device {
    volume_type = "gp3"
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-eks-working-dev-wallet",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-eks-working-dev-wallet",
    Hiware = "True",
    OS_info  = "AWS LINUX AMI 2",
    DEV_GRP  = "bmeta/management/dev",
    Protocol = "SSH_22|SFTP_22",
    Backup   = "True",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}