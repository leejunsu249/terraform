
resource "aws_instance" "hsm-test" {
    ami                    = "ami-0565c45b595578b83"
    instance_type          = "t3.medium"
    iam_instance_profile   = data.terraform_remote_state.comm.outputs.ec2_profile_id

    vpc_security_group_ids = [aws_security_group.hsm_test_sg.id, aws_security_group.management_sg.id]

    subnet_id              = data.terraform_remote_state.network.outputs.mona_subnets[0]
    key_name               = data.terraform_remote_state.comm.outputs.ec2_key_name
    user_data = data.template_file.userdata.rendered
    disable_api_termination = false

    volume_tags = {
        Name = "ec2-${var.aws_shot_region}-${var.environment}-test-tmp-ohio"
    }

    tags = {
        Name = "ec2-${var.aws_shot_region}-${var.environment}-test-tmp-ohio"
    }  
}

## hsm-test
resource "aws_security_group" "hsm_test_sg" {
  name        = "hsm-test-sg"
  description = "Allow monachain inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-hsm-test"
  }
}

resource "aws_security_group_rule" "allow_inbound_hsm_test" {
    description              = "temp peer service from monachain subnets" 
    from_port                = 28051 
    protocol                 = "tcp" 
    to_port                  = 28051
    type                     = "ingress" 
    security_group_id        = aws_security_group.hsm_test_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_outbound_hsm_test" {
    cidr_blocks              = ["0.0.0.0/0"]
    description              = "all from vpc" 
    from_port                = 0 
    protocol                 = "tcp" 
    to_port                  = 65535    
    type                     = "egress" 
    security_group_id        = aws_security_group.hsm_test_sg.id
}

resource "aws_security_group_rule" "allow_inbound_temp_ethereum" {
    description              = "temp peer service from monachain subnets" 
    from_port                = 27051 
    protocol                 = "tcp" 
    to_port                  = 27051
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_ethereum_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_temp_monascan" {
    description              = "temp orderer service from monachain subnets" 
    from_port                = 37050 
    protocol                 = "tcp" 
    to_port                  = 37050
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_monascan_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_temp_publistener" {
    description              = "temp peer service from monachain subnets" 
    from_port                = 27050 
    protocol                 = "tcp" 
    to_port                  = 27050
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_publistener_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_temp_solana" {
    description              = "temp peer service from monachain subnets" 
    from_port                = 18051 
    protocol                 = "tcp" 
    to_port                  = 18051
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_solana_sg.id
    cidr_blocks              = ["10.0.4.192/26"]
}

resource "aws_security_group_rule" "allow_inbound_temp_ethereum_ntls" {
    description              = "hsm network trust link service" 
    from_port                = 1792 
    protocol                 = "tcp" 
    to_port                  = 1792
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_ethereum_sg.id
    cidr_blocks              = ["10.0.0.0/25"]
}

resource "aws_security_group_rule" "allow_inbound_temp_hsmtest_ntls" {
    description              = "hsm network trust link service" 
    from_port                = 1792 
    protocol                 = "tcp" 
    to_port                  = 1792
    type                     = "ingress" 
    security_group_id        = aws_security_group.hsm_test_sg.id
    cidr_blocks              = ["10.0.0.0/25"]
}

resource "aws_security_group_rule" "allow_inbound_temp_monamgr_ntls" {
    description              = "hsm network trust link service" 
    from_port                = 1792 
    protocol                 = "tcp" 
    to_port                  = 1792
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_monamgr_sg.id
    cidr_blocks              = ["10.0.0.0/25"]
}

resource "aws_security_group_rule" "allow_inbound_temp_monarest_ntls" {
    description              = "hsm network trust link service" 
    from_port                = 1792 
    protocol                 = "tcp" 
    to_port                  = 1792
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_monarest_sg.id
    cidr_blocks              = ["10.0.0.0/25"]
}

resource "aws_security_group_rule" "allow_inbound_temp_monascan_ntls" {
    description              = "hsm network trust link service" 
    from_port                = 1792 
    protocol                 = "tcp" 
    to_port                  = 1792
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_monascan_sg.id
    cidr_blocks              = ["10.0.0.0/25"]
}

resource "aws_security_group_rule" "allow_inbound_temp_orderer_ntls" {
    description              = "hsm network trust link service" 
    from_port                = 1792 
    protocol                 = "tcp" 
    to_port                  = 1792
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_orderer_sg.id
    cidr_blocks              = ["10.0.0.0/25"]
}

resource "aws_security_group_rule" "allow_inbound_temp_peer_ntls" {
    description              = "hsm network trust link service" 
    from_port                = 1792 
    protocol                 = "tcp" 
    to_port                  = 1792
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_peer_sg.id
    cidr_blocks              = ["10.0.0.0/25"]
}

resource "aws_security_group_rule" "allow_inbound_temp_publistener_ntls" {
    description              = "hsm network trust link service" 
    from_port                = 1792 
    protocol                 = "tcp" 
    to_port                  = 1792
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_publistener_sg.id
    cidr_blocks              = ["10.0.0.0/25"]
}

resource "aws_security_group_rule" "allow_inbound_temp_solana_ntls" {
    description              = "hsm network trust link service" 
    from_port                = 1792 
    protocol                 = "tcp" 
    to_port                  = 1792
    type                     = "ingress" 
    security_group_id        = aws_security_group.monachain_solana_sg.id
    cidr_blocks              = ["10.0.0.0/25"]
}