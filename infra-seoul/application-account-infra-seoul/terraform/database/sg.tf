resource "aws_security_group" "bcs_rds_sg" {
  name        = "bcs-rds-sg"
  description = "Mona rds Sg for access"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-rds",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_security_group_rule" "allow_monamgr_rds_inbound" {
  description              = "sql from vpc"
  from_port                = 13306
  protocol                 = "tcp"
  to_port                  = 13306
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_rds_sg.id
  source_security_group_id = data.terraform_remote_state.comm.outputs.bcs_monamgr_sg_id
}

resource "aws_security_group_rule" "allow_rds_outbound" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "all from vpc"
  from_port         = 0
  protocol          = "tcp"
  to_port           = 65535
  type              = "egress"
  security_group_id = aws_security_group.bcs_rds_sg.id
}
