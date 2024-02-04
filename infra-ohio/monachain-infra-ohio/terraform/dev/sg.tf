resource "aws_security_group" "management_sg" {
  name        = "management-sg"
  description = "Allow monachain inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-management"
  }
}

resource "aws_security_group_rule" "allow_inbound_management_ssh" {
    description              = "ssh from bastion" 
    from_port                = 22 
    protocol                 = "tcp" 
    to_port                  = 22
    type                     = "ingress" 
    security_group_id        = aws_security_group.management_sg.id
    cidr_blocks              = ["10.0.1.138/32"]
}

resource "aws_security_group_rule" "allow_inbound_management_18080" {
    description              = "middleware/weaver/monarest/monascan webpage" 
    from_port                = 18080 
    protocol                 = "tcp" 
    to_port                  = 18080
    type                     = "ingress" 
    security_group_id        = aws_security_group.management_sg.id
    cidr_blocks              = ["10.0.0.0/25"]
}

resource "aws_security_group_rule" "allow_inbound_eks_secondary_18080" {
    description              = "eks" 
    from_port                = 18080 
    protocol                 = "tcp" 
    to_port                  = 18080
    type                     = "ingress" 
    security_group_id        = aws_security_group.management_sg.id
    cidr_blocks              = data.terraform_remote_state.network.outputs.app_secondary_cidr_blocks
}

resource "aws_security_group_rule" "allow_inbound_monamgr_management_19080" {
    description              = "prometheus webpage" 
    from_port                = 19080
    protocol                 = "tcp" 
    to_port                  = 19080
    type                     = "ingress" 
    security_group_id        = aws_security_group.management_sg.id
    cidr_blocks              = ["10.0.0.0/25"]
}

resource "aws_security_group_rule" "allow_inbound_monamgr_management_19090" {
    description              = "grafana webpage" 
    from_port                = 19090
    protocol                 = "tcp" 
    to_port                  = 19090
    type                     = "ingress" 
    security_group_id        = aws_security_group.management_sg.id
    cidr_blocks              = ["10.0.0.0/25"]
}

resource "aws_security_group_rule" "allow_inbound_monamgr_management_28080" {
    description              = "ngrinder webpage" 
    from_port                = 28080
    protocol                 = "tcp" 
    to_port                  = 28080
    type                     = "ingress" 
    security_group_id        = aws_security_group.management_sg.id
    cidr_blocks              = ["10.0.0.0/25"]
}

resource "aws_security_group_rule" "allow_inbound_solana_management_3000" {
    description              = "metaplex webpage" 
    from_port                = 3000 
    protocol                 = "tcp" 
    to_port                  = 3000
    type                     = "ingress" 
    security_group_id        = aws_security_group.management_sg.id
    cidr_blocks              = ["10.0.0.0/25"]
}

resource "aws_security_group_rule" "allow_outbound_management" {
    cidr_blocks              = ["0.0.0.0/0"]
    description              = "all from vpc" 
    from_port                = 0 
    protocol                 = "tcp" 
    to_port                  = 65535    
    type                     = "egress" 
    security_group_id        = aws_security_group.management_sg.id
}

resource "aws_security_group" "monachain_ethereum_sg" {
  name        = "monachain-ethereum-sg"
  description = "Allow monachain inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-monachain-ethereum"
  }
}

resource "aws_security_group" "monachain_monamgr_sg" {
  name        = "monachain-monamgr-sg"
  description = "Allow monachain inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-monachain-monamgr"
  }
}

resource "aws_security_group" "monachain_monarest_sg" {
  name        = "monachain-monarest-sg"
  description = "Allow monachain inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-monachain-monarest"
  }
}

resource "aws_security_group" "monachain_monascan_sg" {
  name        = "monachain-monascan-sg"
  description = "Allow monachain inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-monachain-monascan"
  }
}

resource "aws_security_group" "monachain_orderer_sg" {
  name        = "monachain-orderer-sg"
  description = "Allow monachain inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-monachain-orderer"
  }
}

resource "aws_security_group" "monachain_peer_sg" {
  name        = "monachain-peer-sg"
  description = "Allow monachain inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-monachain-peer"
  }
}

resource "aws_security_group" "monachain_publistener_sg" {
  name        = "monachain-publistener-sg"
  description = "Allow monachain inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-monachain-publistener"
  }
}

resource "aws_security_group" "monachain_solana_sg" {
  name        = "monachain-solana-sg"
  description = "Allow monachain inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-monachain-solana"
  }
}

resource "aws_security_group_rule" "allow_inbound_monamgr_1" {
    description              = "ngrinder service from monachain subnets" 
    from_port                = 12000 
    protocol                 = "tcp" 
    to_port                  = 12100
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_monamgr_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_monamgr_2" {
    description              = "ngrinder service from monachain subnets" 
    from_port                = 16001 
    protocol                 = "tcp" 
    to_port                  = 16001
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_monamgr_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_monarest" {
    description              = "mona rest service from monachain subnets" 
    from_port                = 18080 
    protocol                 = "tcp" 
    to_port                  = 18080
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_monarest_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_orderer_1" {
    description              = "orderer1 service from monachain subnets" 
    from_port                = 17050 
    protocol                 = "tcp" 
    to_port                  = 17050
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_orderer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_orderer_2" {
    description              = "orderer2 service from monachain subnets" 
    from_port                = 27050 
    protocol                 = "tcp" 
    to_port                  = 27050
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_orderer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_orderer_3" {
    description              = "orderer2 service from monachain subnets" 
    from_port                = 37050 
    protocol                 = "tcp" 
    to_port                  = 37050
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_orderer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_orderer_4" {
    description              = "orderer operation1 service from monachain subnets" 
    from_port                = 17443 
    protocol                 = "tcp" 
    to_port                  = 17443
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_orderer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_orderer_5" {
    description              = "orderer operation2 service from monachain subnets" 
    from_port                = 27443 
    protocol                 = "tcp" 
    to_port                  = 27443
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_orderer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_orderer_6" {
    description              = "orderer operation3 service from monachain subnets" 
    from_port                = 37443 
    protocol                 = "tcp" 
    to_port                  = 37443
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_orderer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_orderer_7" {
    description              = "cadvisor service from monachain subnets" 
    from_port                = 18080 
    protocol                 = "tcp" 
    to_port                  = 18080
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_orderer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_orderer_8" {
    description              = "node exporter service from monachain subnets" 
    from_port                = 19100 
    protocol                 = "tcp" 
    to_port                  = 19100
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_orderer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_peer_1" {
    description              = "peer1 service from monachain subnets" 
    from_port                = 17051 
    protocol                 = "tcp" 
    to_port                  = 17051
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_peer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_peer_2" {
    description              = "peer2 service from monachain subnets" 
    from_port                = 18051 
    protocol                 = "tcp" 
    to_port                  = 18051
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_peer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_peer_3" {
    description              = "peer3 service from monachain subnets" 
    from_port                = 27051 
    protocol                 = "tcp" 
    to_port                  = 27051
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_peer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_peer_4" {
    description              = "peer4 service from monachain subnets" 
    from_port                = 28051 
    protocol                 = "tcp" 
    to_port                  = 28051
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_peer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_peer_5" {
    description              = "peer operation1 service from monachain subnets" 
    from_port                = 17443 
    protocol                 = "tcp" 
    to_port                  = 17443
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_peer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_peer_6" {
    description              = "peer operation2 service from monachain subnets" 
    from_port                = 18443 
    protocol                 = "tcp" 
    to_port                  = 18443
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_peer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_peer_7" {
    description              = "peer operation3 service from monachain subnets" 
    from_port                = 27443 
    protocol                 = "tcp" 
    to_port                  = 27443
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_peer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_peer_8" {
    description              = "peer operation4 service from monachain subnets" 
    from_port                = 28443 
    protocol                 = "tcp" 
    to_port                  = 28443
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_peer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_peer_9" {
    description              = "cadvisor service from monachain subnets" 
    from_port                = 18080 
    protocol                 = "tcp" 
    to_port                  = 18080
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_peer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_peer_10" {
    description              = "node exporter service from monachain subnets" 
    from_port                = 19100 
    protocol                 = "tcp" 
    to_port                  = 19100
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_peer_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_outbound_ethereum" {
    cidr_blocks              = ["0.0.0.0/0"]
    description              = "all from vpc" 
    from_port                = 0 
    protocol                 = "tcp" 
    to_port                  = 65535    
    type                     = "egress" 
    security_group_id        = aws_security_group.monachain_ethereum_sg.id
}

resource "aws_security_group_rule" "allow_outbound_monamgr" {
    cidr_blocks              = ["0.0.0.0/0"]
    description              = "all from vpc" 
    from_port                = 0 
    protocol                 = "tcp" 
    to_port                  = 65535    
    type                     = "egress" 
    security_group_id        = aws_security_group.monachain_monamgr_sg.id
}

resource "aws_security_group_rule" "allow_outbound_monarest" {
    cidr_blocks              = ["0.0.0.0/0"]
    description              = "all from vpc" 
    from_port                = 0 
    protocol                 = "tcp" 
    to_port                  = 65535    
    type                     = "egress" 
    security_group_id        = aws_security_group.monachain_monarest_sg.id
}

resource "aws_security_group_rule" "allow_outbound_monascan" {
    cidr_blocks              = ["0.0.0.0/0"]
    description              = "all from vpc" 
    from_port                = 0 
    protocol                 = "tcp" 
    to_port                  = 65535    
    type                     = "egress" 
    security_group_id        = aws_security_group.monachain_monascan_sg.id
}

resource "aws_security_group_rule" "allow_outbound_orderer" {
    cidr_blocks              = ["0.0.0.0/0"]
    description              = "all from vpc" 
    from_port                = 0 
    protocol                 = "tcp" 
    to_port                  = 65535    
    type                     = "egress" 
    security_group_id        = aws_security_group.monachain_orderer_sg.id
}

resource "aws_security_group_rule" "allow_outbound_peer" {
    cidr_blocks              = ["0.0.0.0/0"]
    description              = "all from vpc" 
    from_port                = 0 
    protocol                 = "tcp" 
    to_port                  = 65535    
    type                     = "egress" 
    security_group_id        = aws_security_group.monachain_peer_sg.id
}

resource "aws_security_group_rule" "allow_outbound_publistener" {
    cidr_blocks              = ["0.0.0.0/0"]
    description              = "all from vpc" 
    from_port                = 0 
    protocol                 = "tcp" 
    to_port                  = 65535    
    type                     = "egress" 
    security_group_id        = aws_security_group.monachain_publistener_sg.id
}

resource "aws_security_group_rule" "allow_outbound_solana" {
    cidr_blocks              = ["0.0.0.0/0"]
    description              = "all from vpc" 
    from_port                = 0 
    protocol                 = "tcp" 
    to_port                  = 65535    
    type                     = "egress" 
    security_group_id        = aws_security_group.monachain_solana_sg.id
}
