resource "aws_security_group" "efs_sg" {
  name        = "efs-sg"
  description = "Allow efs inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-efs",
    System                      = "efs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_inbound_efs" {
  description       = "efs from eks_app"
  from_port         = 2049
  protocol          = "tcp"
  to_port           = 2049
  type              = "ingress"
  security_group_id = aws_security_group.efs_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_efs_file_system" "comm_efs" {
  creation_token = "efs-comm"
  performance_mode = "generalPurpose"
  encrypted = true
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  tags = {
    Name = "efs-${var.aws_shot_region}-${var.environment}-${var.service_name}-comm"
  }
}

resource "aws_efs_mount_target" "efs-mt-zone-a" {
   file_system_id  = aws_efs_file_system.comm_efs.id
   subnet_id = "${element(data.terraform_remote_state.network.outputs.app_subnets,0)}"
   security_groups = [aws_security_group.efs_sg.id]
 }

 resource "aws_efs_mount_target" "efs-mt-zone-b" {
   file_system_id  = aws_efs_file_system.comm_efs.id
   subnet_id = "${element(data.terraform_remote_state.network.outputs.app_subnets,1)}"
   security_groups = [aws_security_group.efs_sg.id]
 }