resource "aws_instance" "ngrinder" {
  count                  = var.environment == "stg" ? 0 : 0
  ami                    = var.common_ami
  instance_type          = "c6i.xlarge"
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.id
  vpc_security_group_ids = [aws_security_group.bcs_ngrinder_sg[0].id, aws_security_group.management_sg.id]

  subnet_id               = data.terraform_remote_state.network.outputs.app_subnets[count.index % 2]
  key_name                = aws_key_pair.ec2_keypair.key_name
  user_data               = data.template_file.userdata_bcs[0].rendered
  disable_api_termination = true

  root_block_device {
    volume_type = "gp3"
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_size = 50
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-ngrinder${count.index + 1}",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  tags = {
    Name    = "ec2-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-ngrinder${count.index + 1}"
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

  lifecycle {
    ignore_changes = [user_data, ebs_block_device, ami]
  }

  depends_on = [aws_kms_key.ec2, aws_ebs_default_kms_key.ebs_kms]
}

data "template_file" "userdata_bcs" {
  count    = var.environment == "stg" ? 0 : 0
  template = file("scripts/user-data-bcs.sh")
  vars = {
    keypair_bcs = "${tls_private_key.bcs_private_key[0].public_key_openssh}"
  }
}

resource "aws_security_group" "bcs_ngrinder_sg" {
  count       = var.environment == "stg" ? 0 : 0
  name        = "bcs-ngrinder-sg"
  description = "Allow monachain inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-bcs-ngrinder",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_security_group_rule" "allow_outbound_ngrinder" {
  count             = var.environment == "stg" ? 0 : 0
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "all from vpc"
  from_port         = 0
  protocol          = "tcp"
  to_port           = 65535
  type              = "egress"
  security_group_id = aws_security_group.bcs_ngrinder_sg[0].id
}

## Internal service domain

resource "aws_route53_record" "private_ngrinder_record" {
  count   = length(aws_instance.ngrinder)
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "nagent${count.index + 1}.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.ngrinder[count.index].private_ip]
}
