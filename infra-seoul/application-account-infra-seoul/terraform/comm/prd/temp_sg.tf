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

resource "aws_security_group_rule" "allow_inbound_monarest_18080_monamgr" {
  description              = "from monamgr"
  from_port                = 18080
  protocol                 = "tcp"
  to_port                  = 18080
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_monarest_sg.id
  source_security_group_id = aws_security_group.bcs_monamgr_sg.id
}

resource "aws_security_group_rule" "allow_inbound_management_monamgr_28080" {
  description       = "ngrinder webpage from vpn"
  from_port         = 28080
  protocol          = "tcp"
  to_port           = 28080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}

#need to terraform import
# terraform import -var-file configurations/prd.tfvars aws_security_group_rule.allow_inbound_management_monamgr_vpn_28080 sg-05e41cb74a773f044_ingress_tcp_28080_28080_172.16.0.0/24
resource "aws_security_group_rule" "allow_inbound_management_monamgr_vpn_28080" {
  description       = "weaver webpage from ssl vpn"
  from_port         = 28080
  protocol          = "tcp"
  to_port           = 28080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["172.16.0.0/24"]
}

resource "aws_security_group_rule" "allow_inbound_monamgr_12000_12100_monarest" {
  description              = "for pf test"
  from_port                = 12000
  protocol                 = "tcp"
  to_port                  = 12100
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_monamgr_sg.id
  source_security_group_id = aws_security_group.bcs_monarest_sg.id
}

resource "aws_security_group_rule" "allow_inbound_monamgr_16001_monarest" {
  description              = "for pf test"
  from_port                = 16001
  protocol                 = "tcp"
  to_port                  = 16001
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_monamgr_sg.id
  source_security_group_id = aws_security_group.bcs_monarest_sg.id
}

resource "aws_security_group_rule" "allow_inbound_alb_18080_monarest" {
  description              = "from monamgr"
  from_port                = 18080
  protocol                 = "tcp"
  to_port                  = 18080
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_alb_sg.id
  source_security_group_id = aws_security_group.bcs_monarest_sg.id
}

resource "aws_security_group_rule" "allow_inbound_monarest_18080_monarest" {
  description              = "from monamgr"
  from_port                = 18080
  protocol                 = "tcp"
  to_port                  = 18080
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_monarest_sg.id
  source_security_group_id = aws_security_group.bcs_monarest_sg.id
}
