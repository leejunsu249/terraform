resource "aws_security_group" "bcs_monamgr_sg" {
  name        = "bcs-monamgr-sg"
  description = "bcs monamgr sg"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-bcs-monamgr",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_security_group" "bcs_monarest_sg" {
  name        = "bcs-monarest-sg"
  description = "bcs monarest sg"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-bcs-monarest",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_security_group" "bcs_orderer_sg" {
  name        = "bcs-orderer-sg"
  description = "bcs orderer sg"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-bcs-orderer",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_security_group" "bcs_peer_sg" {
  name        = "bcs-peer-sg"
  description = "bcs peer sg"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-bcs-peer",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

### wallet vpc - KMS ####

resource "aws_security_group" "wallet_kms_sg" {
  name        = "wallet-kms-sg"
  description = "wallet kms sg"
  vpc_id      = data.terraform_remote_state.network.outputs.wallet_vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-wallet-kms"
  }
}

resource "aws_security_group_rule" "allow_inbound_monarest_18080" {
  description              = "from ALB"
  from_port                = 18080
  protocol                 = "tcp"
  to_port                  = 18080
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_monarest_sg.id
  source_security_group_id = aws_security_group.bcs_alb_sg.id
}

resource "aws_security_group_rule" "allow_inbound_kms_8080" {
  description       = "from bc-central-wallet"
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
  type              = "ingress"
  security_group_id = aws_security_group.wallet_kms_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.wallet_app_secondary_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_kms_8443" {
  description       = "from bc-central-wallet"
  from_port         = 8443
  protocol          = "tcp"
  to_port           = 8443
  type              = "ingress"
  security_group_id = aws_security_group.wallet_kms_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.wallet_app_secondary_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_orderer_17050_1" {
  description              = "peer-orderer from peer"
  from_port                = 17050
  protocol                 = "tcp"
  to_port                  = 17050
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_orderer_sg.id
  source_security_group_id = aws_security_group.bcs_peer_sg.id
}

resource "aws_security_group_rule" "allow_inbound_orderer_17050_2" {
  description              = "orderer etcd/raft cluster"
  from_port                = 17050
  protocol                 = "tcp"
  to_port                  = 17050
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_orderer_sg.id
  source_security_group_id = aws_security_group.bcs_orderer_sg.id
}

resource "aws_security_group_rule" "allow_inbound_orderer_17050_3" {
  description              = "orderer connect from rest"
  from_port                = 17050
  protocol                 = "tcp"
  to_port                  = 17050
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_orderer_sg.id
  source_security_group_id = aws_security_group.bcs_monarest_sg.id
}

resource "aws_security_group_rule" "allow_inbound_orderer_17050_4" {
  description              = "orderer connecto from mona-mgr"
  from_port                = 17050
  protocol                 = "tcp"
  to_port                  = 17050
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_orderer_sg.id
  source_security_group_id = aws_security_group.bcs_monamgr_sg.id
}

resource "aws_security_group_rule" "allow_inbound_orderer_17443_1" {
  description              = "orderer metric service from monarest"
  from_port                = 17443
  protocol                 = "tcp"
  to_port                  = 17443
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_orderer_sg.id
  source_security_group_id = aws_security_group.bcs_monarest_sg.id
}

resource "aws_security_group_rule" "allow_inbound_orderer_17443_2" {
  description              = "orderer metric service from monamgr"
  from_port                = 17443
  protocol                 = "tcp"
  to_port                  = 17443
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_orderer_sg.id
  source_security_group_id = aws_security_group.bcs_monamgr_sg.id
}

resource "aws_security_group_rule" "allow_inbound_peer_17051" {
  description              = "peer gossip connection"
  from_port                = 17051
  protocol                 = "tcp"
  to_port                  = 17051
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_peer_sg.id
  source_security_group_id = aws_security_group.bcs_peer_sg.id
}

resource "aws_security_group_rule" "allow_inbound_peer_17051_2" {
  description              = "orderer-peer from orderer"
  from_port                = 17051
  protocol                 = "tcp"
  to_port                  = 17051
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_peer_sg.id
  source_security_group_id = aws_security_group.bcs_orderer_sg.id
}

resource "aws_security_group_rule" "allow_inbound_peer_17051_3" {
  description              = "peer connect from rest"
  from_port                = 17051
  protocol                 = "tcp"
  to_port                  = 17051
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_peer_sg.id
  source_security_group_id = aws_security_group.bcs_monarest_sg.id
}

resource "aws_security_group_rule" "allow_inbound_peer_17051_4" {
  description              = "peer connect from mona-mgr"
  from_port                = 17051
  protocol                 = "tcp"
  to_port                  = 17051
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_peer_sg.id
  source_security_group_id = aws_security_group.bcs_monamgr_sg.id
}

resource "aws_security_group_rule" "allow_inbound_peer_17443_1" {
  description              = "peer metric from monarest"
  from_port                = 17443
  protocol                 = "tcp"
  to_port                  = 17443
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_peer_sg.id
  source_security_group_id = aws_security_group.bcs_monarest_sg.id
}

resource "aws_security_group_rule" "allow_inbound_peer_17443_2" {
  description              = "peer metric from monamgr"
  from_port                = 17443
  protocol                 = "tcp"
  to_port                  = 17443
  type                     = "ingress"
  security_group_id        = aws_security_group.bcs_peer_sg.id
  source_security_group_id = aws_security_group.bcs_monamgr_sg.id
}

resource "aws_security_group_rule" "allow_inbound_kms_8080_nlb" {
  description       = "health check from nlb"
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
  type              = "ingress"
  security_group_id = aws_security_group.wallet_kms_sg.id
  cidr_blocks       = formatlist("%s/32", data.aws_network_interface.wallet_nlb.*.private_ip)
}

resource "aws_security_group_rule" "allow_inbound_kms_8443_nlb" {
  description       = "health check from nlb"
  from_port         = 8443
  protocol          = "tcp"
  to_port           = 8443
  type              = "ingress"
  security_group_id = aws_security_group.wallet_kms_sg.id
  cidr_blocks       = formatlist("%s/32", data.aws_network_interface.wallet_nlb.*.private_ip)
}

## management rule
resource "aws_security_group_rule" "allow_inbound_management_monarest_18080" {
  description       = "temp test"
  from_port         = 18080
  protocol          = "tcp"
  to_port           = 18080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monarest_sg.id
  cidr_blocks       = ["192.168.1.48/32"]
}

# need to terraform import
resource "aws_security_group_rule" "allow_inbound_management_vpn_monarest_18080" {
  description       = "REST API webpage from forti-ssl vpn"
  from_port         = 18080
  protocol          = "tcp"
  to_port           = 18080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monarest_sg.id
  cidr_blocks       = ["172.16.0.0/24"]
}

resource "aws_security_group_rule" "allow_inbound_management_monamgr_18080" {
  description       = "weaver webpage from vpn"
  from_port         = 18080
  protocol          = "tcp"
  to_port           = 18080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}

# need to terraform import
resource "aws_security_group_rule" "allow_inbound_management_monamgr_vpn_18080" {
  description       = "weaver webpage from ssl vpn"
  from_port         = 18080
  protocol          = "tcp"
  to_port           = 18080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["172.16.0.0/24"]
}

resource "aws_security_group_rule" "allow_inbound_management_monamgr_19080" {
  description       = "prometheus webpage from vpn"
  from_port         = 19080
  protocol          = "tcp"
  to_port           = 19080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}

# need to terraform import
resource "aws_security_group_rule" "allow_inbound_management_monamgr_vpn_19080" {
  description       = "weaver webpage from ssl vpn"
  from_port         = 19080
  protocol          = "tcp"
  to_port           = 19080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["172.16.0.0/24"]
}

resource "aws_security_group_rule" "allow_inbound_management_monamgr_19090" {
  description       = "grafana webpage from vpn"
  from_port         = 19090
  protocol          = "tcp"
  to_port           = 19090
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}

# resource "aws_security_group_rule" "allow_inbound_management_kms_8080" {
#   description       = "from vpn"
#   from_port         = 8080
#   protocol          = "tcp"
#   to_port           = 8080
#   type              = "ingress"
#   security_group_id = aws_security_group.wallet_kms_sg.id
#   cidr_blocks       = ["192.168.1.0/24", "192.168.10.0/24"]
# }

# resource "aws_security_group_rule" "allow_inbound_management_kms_8443" {
#   description       = "from vpn"
#   from_port         = 8443
#   protocol          = "tcp"
#   to_port           = 8443
#   type              = "ingress"
#   security_group_id = aws_security_group.wallet_kms_sg.id
#   cidr_blocks       = ["192.168.1.0/24", "192.168.10.0/24"]
# }

resource "aws_security_group_rule" "allow_outbound_monamgr" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "all from vpc"
  from_port         = 0
  protocol          = "tcp"
  to_port           = 65535
  type              = "egress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
}

resource "aws_security_group_rule" "allow_outbound_monarest" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "all from vpc"
  from_port         = 0
  protocol          = "tcp"
  to_port           = 65535
  type              = "egress"
  security_group_id = aws_security_group.bcs_monarest_sg.id
}

resource "aws_security_group_rule" "allow_outbound_orderer" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "all from vpc"
  from_port         = 0
  protocol          = "tcp"
  to_port           = 65535
  type              = "egress"
  security_group_id = aws_security_group.bcs_orderer_sg.id
}

resource "aws_security_group_rule" "allow_outbound_peer" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "all from vpc"
  from_port         = 0
  protocol          = "tcp"
  to_port           = 65535
  type              = "egress"
  security_group_id = aws_security_group.bcs_peer_sg.id
}

resource "aws_security_group_rule" "allow_outbound_kms" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "all from vpc"
  from_port         = 0
  protocol          = "tcp"
  to_port           = 65535
  type              = "egress"
  security_group_id = aws_security_group.wallet_kms_sg.id
}
