resource "aws_security_group_rule" "allow_inbound_alb_18080_monamgr" {
  description              = "from monamgr"
  from_port                = 18080
  protocol                 = "tcp"
  to_port                  = 18080
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_alb_sg.id
  source_security_group_id = aws_security_group.bcs_monamgr_sg.id
}

resource "aws_security_group_rule" "allow_inbound_monamgr_12000_12100_ngrinder" {
  description       = "test metric from ngrinder"
  from_port         = 12000
  protocol          = "tcp"
  to_port           = 12100
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = data.terraform_remote_state.network_ue2.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_monamgr_16001_ngrinder" {
  description       = "controller connection from ngrinder"
  from_port         = 16001
  protocol          = "tcp"
  to_port           = 16001
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = data.terraform_remote_state.network_ue2.outputs.app_cidr_blocks
}

# resource "aws_security_group_rule" "allow_inbound_monarest_18080_ngrinder" {
#   description       = "controller connection from ngrinder"
#   from_port         = 18080
#   protocol          = "tcp"
#   to_port           = 18080
#   type              = "ingress"
#   security_group_id = aws_security_group.bcs_monarest_sg.id
#   cidr_blocks       = data.terraform_remote_state.network_ue2.outputs.app_cidr_blocks
# }

# resource "aws_security_group_rule" "allow_inbound_monarest_18080_monamgr" {
#   description              = "controller connection from ngrinder"
#   from_port                = 18080
#   protocol                 = "tcp"
#   to_port                  = 18080
#   type                     = "ingress"
#   security_group_id        = aws_security_group.bcs_monarest_sg.id
#   source_security_group_id = aws_security_group.bcs_monamgr_sg.id
# }
