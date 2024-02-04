resource "aws_instance" "peer1" {
  ami           = "ami-01d6db53cf1a48f9b"
  instance_type = var.environment == "dev" ? var.peer1_instance_type : var.bcs_instance_type

  iam_instance_profile = data.terraform_remote_state.comm.outputs.ec2_profile_id

  vpc_security_group_ids = [aws_security_group.bcs_peer_sg.id, aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.app_subnets[0]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = data.template_file.userdata_bcs.rendered
  disable_api_termination = true

  lifecycle { ignore_changes = [ebs_block_device, user_data] }

  root_block_device {
    volume_type = "gp3"
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 200
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-peer",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-peer",
    Hiware = "True",
    OS_info  = "AWS LINUX AMI 2",
    DEV_GRP  = "bmeta/bcs/${var.environment}",
    Protocol = "SSH_22|SFTP_22",
    Backup   = "True",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  depends_on = [aws_kms_key.ec2, aws_ebs_default_kms_key.ebs_kms]
}

resource "aws_instance" "orderer1" {
  ami                  = "ami-0069e58f8e7e73955"
  instance_type        = var.bcs_instance_type
  iam_instance_profile = data.terraform_remote_state.comm.outputs.ec2_profile_id

  vpc_security_group_ids = [aws_security_group.bcs_orderer_sg.id, aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.app_subnets[0]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = data.template_file.userdata_bcs.rendered
  disable_api_termination = true

  lifecycle { ignore_changes = [ebs_block_device, user_data] }

  root_block_device {
    volume_type = "gp3"
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 200
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-orderer",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-orderer",
    Hiware = "True",
    OS_info  = "AWS LINUX AMI 2",
    DEV_GRP  = "bmeta/bcs/${var.environment}",
    Protocol = "SSH_22|SFTP_22",
    Backup   = "True",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  depends_on = [aws_kms_key.ec2, aws_ebs_default_kms_key.ebs_kms]
}

resource "aws_instance" "monarest" {
  ami                  = var.common_ami
  instance_type        = var.bcs_instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_bcs_profile.id

  vpc_security_group_ids = [aws_security_group.bcs_monarest_sg.id, aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.app_subnets[0]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = data.template_file.userdata_bcs.rendered
  disable_api_termination = true

  lifecycle { ignore_changes = [ebs_block_device, user_data] }

  root_block_device {
    volume_type = "gp3"
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 100
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-monarest",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-monarest",
    Hiware = "True",
    OS_info  = "AWS LINUX AMI 2",
    DEV_GRP  = "bmeta/bcs/${var.environment}",
    Protocol = "SSH_22|SFTP_22",
    Backup   = "True"
    Deploy_app = "deploy-monarest",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  depends_on = [aws_kms_key.ec2, aws_ebs_default_kms_key.ebs_kms]
}

resource "aws_instance" "monamgr" {
  ami                  = var.common_ami
  instance_type        = var.bcs_instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_bcs_profile.id

  vpc_security_group_ids = [aws_security_group.bcs_monamgr_sg.id, aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.app_subnets[0]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = data.template_file.userdata_bcs.rendered
  disable_api_termination = true

  lifecycle { ignore_changes = [ebs_block_device, user_data] }

  root_block_device {
    volume_type = "gp3"
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 100
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-monamgr",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-monamgr",
    Hiware = "True",
    OS_info  = "AWS LINUX AMI 2",
    DEV_GRP  = "bmeta/bcs/${var.environment}",
    Protocol = "SSH_22|SFTP_22",
    Backup   = "True"
    Deploy_app = "deploy-chaincode",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  depends_on = [aws_kms_key.ec2, aws_ebs_default_kms_key.ebs_kms]
}

resource "aws_instance" "kms" {
  count                = var.kms.count
  ami                  = var.kms.ami
  instance_type        = var.kms.instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_wallet_profile.id

  vpc_security_group_ids = [aws_security_group.wallet_kms_sg.id, aws_security_group.wallet_management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.wallet_app_subnets[0]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = data.template_file.userdata_wallet.rendered
  disable_api_termination = true

  lifecycle { ignore_changes = [ebs_block_device, user_data] }

  root_block_device {
    volume_type = "gp3"
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = var.kms.disk
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-kms",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-kms",
    Hiware = "True",
    OS_info  = "AWS LINUX AMI 2",
    DEV_GRP  = "bmeta/wallet/${var.environment}",
    Protocol = "SSH_22|SFTP_22",
    Backup   = "True"
    Deploy_app = "deploy-kms",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  depends_on = [aws_kms_key.ec2, aws_ebs_default_kms_key.ebs_kms]
}

## Internal service domain

resource "aws_route53_record" "private_orderer1_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "orderer1.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.orderer1.private_ip]
}

resource "aws_route53_record" "private_orderer2_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "orderer2.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.orderer1.private_ip]
}

resource "aws_route53_record" "private_orderer3_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "orderer3.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.orderer1.private_ip]
}

resource "aws_route53_record" "private_peer1_bm1_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "peer1.bm1.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.peer1.private_ip]
}

resource "aws_route53_record" "private_peer2_bm1_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "peer2.bm1.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.peer1.private_ip]
}

resource "aws_route53_record" "private_peer1_bm2_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "peer1.bm2.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.peer1.private_ip]
}

resource "aws_route53_record" "private_peer2_bm2_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "peer2.bm2.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.peer1.private_ip]
}

resource "aws_route53_record" "private_kms_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "kms.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = var.environment == "dev" ? "A" : "CNAME"
  ttl     = 300
  records = var.environment == "dev" ? [aws_instance.kms[0].private_ip] : [aws_lb.kms_alb[0].dns_name]
}

## domain from web

resource "aws_route53_record" "private_monarest_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "mona-rest.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.monarest.private_ip]
}

resource "aws_route53_record" "private_monamgr_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "mona-mgr.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.monamgr.private_ip]
}


