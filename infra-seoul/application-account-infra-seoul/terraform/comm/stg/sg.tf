resource "aws_security_group" "bcs_monamgr_sg" {
  name        = "bcs-monamgr-sg"
  description = "Allow bcs inbound traffic"
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
  description = "Allow bcs inbound traffic"
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
  description = "Allow bcs inbound traffic"
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
  description = "Allow monachain inbound traffic"
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
  description = "Allow bcs inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.wallet_vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-wallet-kms",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
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
  description       = "REST API webpage from vpn"
  from_port         = 18080
  protocol          = "tcp"
  to_port           = 18080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monarest_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}

# terraform import -var-file configurations/stg.tfvars aws_security_group_rule.allow_inbound_forti_ssl_18080 sg-060889b79d477b5a4_ingress_tcp_18080_18080_172.16.0.0/24
resource "aws_security_group_rule" "allow_inbound_forti_ssl_18080" {
  description       = "REST API webpage from forti-ssl vpn"
  from_port         = 18080
  protocol          = "tcp"
  to_port           = 18080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monarest_sg.id
  cidr_blocks       = ["172.16.0.0/24"]
}

# terraform import -var-file configurations/stg.tfvars aws_security_group_rule.allow_inbound_management_monamgr2_18080 sg-03dd8cfccc4863099_ingress_tcp_18080_18080_192.168.1.0/24
resource "aws_security_group_rule" "allow_inbound_management_monamgr2_18080" {
  description       = "weaver webpage from wallet-vpn-2"
  from_port         = 18080
  protocol          = "tcp"
  to_port           = 18080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}

resource "aws_security_group_rule" "allow_inbound_management_monamgr_18080" {
  description       = "weaver webpage from wallet-vpn"
  from_port         = 18080
  protocol          = "tcp"
  to_port           = 18080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["192.168.10.0/24"]
}

resource "aws_security_group_rule" "allow_inbound_management_monamgr_19080" {
  description       = "prometheus webpage from vpn-2"
  from_port         = 19080
  protocol          = "tcp"
  to_port           = 19080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}

resource "aws_security_group_rule" "allow_inbound_management_monamgr_19090" {
  description       = "grafana webpage from vpn-2"
  from_port         = 19090
  protocol          = "tcp"
  to_port           = 19090
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}

resource "aws_security_group_rule" "allow_inbound_management_monamgr_28080" {
  description       = "ngrinder webpage from vpn-2"
  from_port         = 28080
  protocol          = "tcp"
  to_port           = 28080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}

# terraform import -var-file configurations/stg.tfvars aws_security_group_rule.allow_inbound_vpn_grafana_19090 sg-03dd8cfccc4863099_ingress_tcp_19090_19090_192.168.10.0/24
resource "aws_security_group_rule" "allow_inbound_vpn_grafana_19090" {
  description       = "grafana webpage from vpn"
  from_port         = 19090
  protocol          = "tcp"
  to_port           = 19090
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["192.168.10.0/24"]
}

# terraform import -var-file configurations/stg.tfvars aws_security_group_rule.allow_inbound_vpn_grafana2_19090 sg-03dd8cfccc4863099_ingress_tcp_19090_19090_172.16.0.0/24
resource "aws_security_group_rule" "allow_inbound_vpn_grafana2_19090" {
  description       = "grafana webpage from vpn"
  from_port         = 19090
  protocol          = "tcp"
  to_port           = 19090
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["172.16.0.0/24"]
}

# terraform import -var-file configurations/stg.tfvars aws_security_group_rule.allow_inbound_vpn_prometheus_19080 sg-03dd8cfccc4863099_ingress_tcp_19080_19080_172.16.0.0/24
resource "aws_security_group_rule" "allow_inbound_vpn_prometheus_19080" {
  description       = "prometheus webpage from vpn"
  from_port         = 19080
  protocol          = "tcp"
  to_port           = 19080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["172.16.0.0/24"]
}

# terraform import -var-file configurations/stg.tfvars aws_security_group_rule.allow_inbound_vpn_prometheus2_19080 sg-03dd8cfccc4863099_ingress_tcp_19080_19080_192.168.10.0/24
resource "aws_security_group_rule" "allow_inbound_vpn_prometheus2_19080" {
  description       = "prometheus webpage from vpn"
  from_port         = 19080
  protocol          = "tcp"
  to_port           = 19080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["192.168.10.0/24"]
}

# terraform import -var-file configurations/stg.tfvars aws_security_group_rule.allow_inbound_vpn_ngrinder_19090 sg-03dd8cfccc4863099_ingress_tcp_28080_28080_172.16.0.0/24_192.168.10.0/24
resource "aws_security_group_rule" "allow_inbound_vpn_ngrinder_19090" {
  description       = "ngrinder webpage from vpn"
  from_port         = 28080
  protocol          = "tcp"
  to_port           = 28080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["172.16.0.0/24", "192.168.10.0/24"]
}

# terraform import -var-file configurations/stg.tfvars aws_security_group_rule.allow_inbound_vpn_watll_ssl_18080 sg-03dd8cfccc4863099_ingress_tcp_18080_18080_172.16.1.0/24
resource "aws_security_group_rule" "allow_inbound_vpn_watll_ssl_18080" {
  description       = "weaver webpage from watll-ssl-vpn"
  from_port         = 18080
  protocol          = "tcp"
  to_port           = 18080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["172.16.1.0/24"]
}

# resource "aws_security_group_rule" "allow_inbound_vpn_watll_ssl2_18080" {
#   description       = "weaver webpage from watll-ssl-vpn"
#   from_port         = 18080
#   protocol          = "tcp"
#   to_port           = 18080
#   type              = "ingress"
#   security_group_id = aws_security_group.bcs_monamgr_sg.id
#   cidr_blocks       = ["172.16.0.0/24"]
# }

resource "aws_security_group_rule" "allow_inbound_management_kms_8080" {
  description       = "from vpn"
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
  type              = "ingress"
  security_group_id = aws_security_group.wallet_kms_sg.id
  cidr_blocks       = ["192.168.1.0/24", "192.168.10.0/24"]
}

resource "aws_security_group_rule" "allow_inbound_management_kms_8443" {
  description       = "from vpn"
  from_port         = 8443
  protocol          = "tcp"
  to_port           = 8443
  type              = "ingress"
  security_group_id = aws_security_group.wallet_kms_sg.id
  cidr_blocks       = ["192.168.1.0/24", "192.168.10.0/24"]
}

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
