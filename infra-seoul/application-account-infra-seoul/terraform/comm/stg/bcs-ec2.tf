resource "aws_instance" "orderer" {
  count                = var.orderer.count
  ami                  = var.common_ami
  instance_type        = var.orderer.instance_type
  iam_instance_profile = data.terraform_remote_state.comm.outputs.ec2_profile_id

  vpc_security_group_ids = [aws_security_group.bcs_orderer_sg.id, aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.app_subnets[count.index % 3]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = data.template_file.userdata_bcs.rendered
  disable_api_termination = true

  lifecycle { ignore_changes = [ebs_block_device, user_data, ami] }

  root_block_device {
    volume_type = "gp3"
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = var.orderer.disk
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-orderer${count.index + 1}",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-orderer${count.index + 1}",
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

resource "aws_instance" "peer" {
  count         = var.peer.count
  ami           = var.common_ami
  instance_type = var.peer.instance_type

  iam_instance_profile = data.terraform_remote_state.comm.outputs.ec2_profile_id

  vpc_security_group_ids = [aws_security_group.bcs_peer_sg.id, aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.app_subnets[count.index % 3]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = data.template_file.userdata_bcs.rendered
  disable_api_termination = true

  lifecycle { ignore_changes = [ebs_block_device, user_data, ami] }

  root_block_device {
    volume_type = "gp3"
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = var.peer.disk
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-peer${count.index + 1}",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-peer${count.index + 1}",
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
  count                = var.monarest.count
  ami                  = var.common_ami
  instance_type        = var.monarest.instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_bcs_profile.id

  vpc_security_group_ids = [aws_security_group.bcs_monarest_sg.id, aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.app_subnets[count.index % 3]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = data.template_file.userdata_bcs.rendered
  disable_api_termination = true

  lifecycle { ignore_changes = [ebs_block_device, user_data, ami] }

  root_block_device {
    volume_type = "gp3"
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = var.monarest.disk
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-monarest${count.index + 1}",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-monarest${count.index + 1}",
    Hiware = "True",
    OS_info  = "AWS LINUX AMI 2",
    DEV_GRP  = "bmeta/bcs/${var.environment}",
    Protocol = "SSH_22|SFTP_22",
    Backup   = "True",
    Deploy_app = "deploy-monarest",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  depends_on = [aws_kms_key.ec2, aws_ebs_default_kms_key.ebs_kms]
}

resource "aws_instance" "monamgr" {
  count                = var.monamgr.count
  ami                  = var.common_ami
  instance_type        = var.monamgr.instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_bcs_profile.id

  vpc_security_group_ids = [aws_security_group.bcs_monamgr_sg.id, aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.app_subnets[count.index % 3]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = data.template_file.userdata_bcs.rendered
  disable_api_termination = true

  lifecycle { ignore_changes = [ebs_block_device, user_data, ami] }

  root_block_device {
    volume_type = "gp3"
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = var.monamgr.disk
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
    Backup   = "True",
    Deploy_app = "deploy-chaincode",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  depends_on = [aws_kms_key.ec2, aws_ebs_default_kms_key.ebs_kms]
}

### wallet vpc - KMS ####

resource "aws_instance" "kms" {
  count                = var.kms.count
  ami                  = var.common_ami
  instance_type        = var.kms.instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_wallet_profile.id

  vpc_security_group_ids = [aws_security_group.wallet_kms_sg.id, aws_security_group.wallet_management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.wallet_app_subnets[count.index % 2]
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
    Name = "ec2-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-kms${count.index + 1}",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  tags = {
    Name   = "ec2-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-kms${count.index + 1}",
    Hiware = "True",
    OS_info  = "AWS LINUX AMI 2",
    DEV_GRP  = "bmeta/wallet/${var.environment}",
    Protocol = "SSH_22|SFTP_22",
    Backup   = "True",
    Deploy_app = "deploy-kms",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  depends_on = [aws_kms_key.ec2, aws_ebs_default_kms_key.ebs_kms]
}

## Internal service domain

resource "aws_route53_record" "private_orderer1_record" {
  count   = length(aws_instance.orderer)
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "orderer${count.index + 1}.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.orderer[count.index].private_ip]
}

resource "aws_route53_record" "private_peer1_bm1_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "peer1.bm1.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.peer[0].private_ip]
}

resource "aws_route53_record" "private_peer2_bm1_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "peer2.bm1.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.peer[1].private_ip]
}

resource "aws_route53_record" "private_peer1_bm2_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "peer1.bm2.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.peer[2].private_ip]
}

resource "aws_route53_record" "private_peer2_bm2_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "peer2.bm2.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.peer[3].private_ip]
}

resource "aws_route53_record" "private_monarest_record" {
  count   = length(aws_instance.monarest)
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "mona-rest${count.index + 1}.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.monarest[count.index].private_ip]
}

resource "aws_route53_record" "private_monamgr_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "mona-mgr.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.monamgr[0].private_ip]
}
