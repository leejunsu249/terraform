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

resource "aws_security_group_rule" "allow_inbound_orderer_1" {
  description       = "orderer conection from bcs subnets"
  from_port         = 17050
  protocol          = "tcp"
  to_port           = 17050
  type              = "ingress"
  security_group_id = aws_security_group.bcs_orderer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_orderer_2" {
  description       = "orderer conection from bcs subnets"
  from_port         = 27050
  protocol          = "tcp"
  to_port           = 27050
  type              = "ingress"
  security_group_id = aws_security_group.bcs_orderer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_orderer_3" {
  description       = "orderer conection from bcs subnets"
  from_port         = 37050
  protocol          = "tcp"
  to_port           = 37050
  type              = "ingress"
  security_group_id = aws_security_group.bcs_orderer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_orderer_4" {
  description       = "orderer metric service from bcs subnets"
  from_port         = 17443
  protocol          = "tcp"
  to_port           = 17443
  type              = "ingress"
  security_group_id = aws_security_group.bcs_orderer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_orderer_5" {
  description       = "orderer metric service from bcs subnets"
  from_port         = 27443
  protocol          = "tcp"
  to_port           = 27443
  type              = "ingress"
  security_group_id = aws_security_group.bcs_orderer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_orderer_6" {
  description       = "orderer metric service from bcs subnets"
  from_port         = 37443
  protocol          = "tcp"
  to_port           = 37443
  type              = "ingress"
  security_group_id = aws_security_group.bcs_orderer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_orderer_7" {
  description       = "docker metric from bcs subnets"
  from_port         = 18080
  protocol          = "tcp"
  to_port           = 18080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_orderer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_orderer_8" {
  description       = "node metric from bcs subnets"
  from_port         = 19100
  protocol          = "tcp"
  to_port           = 19100
  type              = "ingress"
  security_group_id = aws_security_group.bcs_orderer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_peer_1" {
  description       = "peer connection from bcs subnets"
  from_port         = 17051
  protocol          = "tcp"
  to_port           = 17051
  type              = "ingress"
  security_group_id = aws_security_group.bcs_peer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_peer_2" {
  description       = "peer connection from bcs subnets"
  from_port         = 18051
  protocol          = "tcp"
  to_port           = 18051
  type              = "ingress"
  security_group_id = aws_security_group.bcs_peer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_peer_3" {
  description       = "peer connection from bcs subnets"
  from_port         = 27051
  protocol          = "tcp"
  to_port           = 27051
  type              = "ingress"
  security_group_id = aws_security_group.bcs_peer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_peer_4" {
  description       = "peer connection from bcs subnets"
  from_port         = 28051
  protocol          = "tcp"
  to_port           = 28051
  type              = "ingress"
  security_group_id = aws_security_group.bcs_peer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_peer_5" {
  description       = "peer metric from bcs subnets"
  from_port         = 17443
  protocol          = "tcp"
  to_port           = 17443
  type              = "ingress"
  security_group_id = aws_security_group.bcs_peer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_peer_6" {
  description       = "peer metric from bcs subnets"
  from_port         = 18443
  protocol          = "tcp"
  to_port           = 18443
  type              = "ingress"
  security_group_id = aws_security_group.bcs_peer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_peer_7" {
  description       = "peer metric from bcs subnets"
  from_port         = 27443
  protocol          = "tcp"
  to_port           = 27443
  type              = "ingress"
  security_group_id = aws_security_group.bcs_peer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_peer_8" {
  description       = "peer metric from bcs subnets"
  from_port         = 28443
  protocol          = "tcp"
  to_port           = 28443
  type              = "ingress"
  security_group_id = aws_security_group.bcs_peer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_peer_9" {
  description       = "docker metric from bcs subnets"
  from_port         = 18080
  protocol          = "tcp"
  to_port           = 18080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_peer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_peer_10" {
  description       = "node metric from bcs subnets"
  from_port         = 19100
  protocol          = "tcp"
  to_port           = 19100
  type              = "ingress"
  security_group_id = aws_security_group.bcs_peer_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.app_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_monarest_18080" {
  description       = "from middleware"
  from_port         = 18080
  protocol          = "tcp"
  to_port           = 18080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monarest_sg.id
  cidr_blocks       = data.terraform_remote_state.network_ue2.outputs.app_cidr_blocks
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

resource "aws_security_group_rule" "allow_inbound_management_monamgr_18080" {
  description       = "weaver webpage from vpn"
  from_port         = 18080
  protocol          = "tcp"
  to_port           = 18080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}

resource "aws_security_group_rule" "allow_inbound_monamgr_19080" {
  description       = "prometheus webpage from vpn"
  from_port         = 19080
  protocol          = "tcp"
  to_port           = 19080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}

resource "aws_security_group_rule" "allow_inbound_monamgr_19090" {
  description       = "grafana webpage from vpn"
  from_port         = 19090
  protocol          = "tcp"
  to_port           = 19090
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["192.168.1.0/24"]
}

resource "aws_security_group_rule" "allow_inbound_monamgr_28080" {
  description       = "ngrinder webpage from vpn"
  from_port         = 28080
  protocol          = "tcp"
  to_port           = 28080
  type              = "ingress"
  security_group_id = aws_security_group.bcs_monamgr_sg.id
  cidr_blocks       = ["10.0.0.0/25"]
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

### wallet vpc - KMS ####
resource "aws_security_group" "wallet_kms_sg" {
  name        = "wallet-kms-sg"
  description = "kms sg"
  vpc_id      = data.terraform_remote_state.network.outputs.wallet_vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-wallet-kms",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_security_group_rule" "allow_inbound_kms_8080" {
  description       = "from bc-centralwallet"
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
  type              = "ingress"
  security_group_id = aws_security_group.wallet_kms_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.wallet_app_secondary_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_kms_8443" {
  description       = "from bc-centralwallet"
  from_port         = 8443
  protocol          = "tcp"
  to_port           = 8443
  type              = "ingress"
  security_group_id = aws_security_group.wallet_kms_sg.id
  cidr_blocks       = data.terraform_remote_state.network.outputs.wallet_app_secondary_cidr_blocks
}


# terraform import -var-file configurations/dev.tfvars aws_security_group_rule.allow_inbound_management_kms_8080 sg-0851750d85e121492_ingress_tcp_8080_8080_192.168.10.0/24
resource "aws_security_group_rule" "allow_inbound_management_kms_8080" {
  description       = "from vpn"
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
  type              = "ingress"
  security_group_id = aws_security_group.wallet_kms_sg.id
  cidr_blocks       = ["192.168.10.0/24"]
}
# terraform import -var-file configurations/dev.tfvars aws_security_group_rule.allow_inbound_management_kms_8443 sg-0851750d85e121492_ingress_tcp_8443_8443_192.168.10.0/24
resource "aws_security_group_rule" "allow_inbound_management_kms_8443" {
  description       = "from vpn"
  from_port         = 8443
  protocol          = "tcp"
  to_port           = 8443
  type              = "ingress"
  security_group_id = aws_security_group.wallet_kms_sg.id
  cidr_blocks       = ["192.168.10.0/24"]
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

resource "aws_security_group_rule" "allow_outbound_kms" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "all from vpc"
  from_port         = 0
  protocol          = "tcp"
  to_port           = 65535
  type              = "egress"
  security_group_id = aws_security_group.wallet_kms_sg.id
}

resource "aws_security_group_rule" "allow_inbound_alb_kms_8443" {
  count             = var.environment == "dev" ? 0 : 1
  description       = "from kms alb 8443"
  from_port         = 8443
  protocol          = "tcp"
  to_port           = 8443
  type              = "ingress"
  security_group_id = aws_security_group.wallet_kms_sg.id
  source_security_group_id = aws_security_group.allow_lb_kms[0].id
}

resource "aws_security_group_rule" "allow_inbound_alb_kms_8080" {
  count             = var.environment == "dev" ? 0 : 1  
  description       = "from kms alb 8080"
  from_port         = 8080
  protocol          = "tcp"
  to_port           = 8080
  type              = "ingress"
  security_group_id = aws_security_group.wallet_kms_sg.id
  source_security_group_id = aws_security_group.allow_lb_kms[0].id
}