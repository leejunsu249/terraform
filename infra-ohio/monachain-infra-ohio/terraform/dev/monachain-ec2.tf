# resource "aws_instance" "peer1" {
#     ami                    = var.default_ami
#     instance_type          = var.monachain_instance_type

#     iam_instance_profile   = data.terraform_remote_state.comm.outputs.ec2_profile_id

#     vpc_security_group_ids = [aws_security_group.monachain_peer_sg.id,aws_security_group.management_sg.id]

#     subnet_id              = data.terraform_remote_state.network.outputs.mona_subnets[0]
#     key_name               = data.terraform_remote_state.comm.outputs.ec2_key_name
#     user_data = data.template_file.userdata.rendered
#     disable_api_termination = true

#     lifecycle {  ignore_changes = [ebs_block_device] }

#     root_block_device {
#         volume_type = "gp3"
#     }

#     ebs_block_device {
#         device_name = "/dev/sdf"
#         volume_size = 200
#     }

#     volume_tags = {
#         Name = "ec2-${var.aws_shot_region}-${var.environment}-monachain-peer"
#     }

#     tags = {
#         Name = "ec2-${var.aws_shot_region}-${var.environment}-monachain-peer"
#         Backup = "True"
#     }  
# }

# resource "aws_instance" "orderer1" {
#     ami                    = var.default_ami
#     instance_type          = var.monachain_instance_type
#     iam_instance_profile   = data.terraform_remote_state.comm.outputs.ec2_profile_id

#     vpc_security_group_ids = [aws_security_group.monachain_orderer_sg.id,aws_security_group.management_sg.id]

#     subnet_id              = data.terraform_remote_state.network.outputs.mona_subnets[0]
#     key_name               = data.terraform_remote_state.comm.outputs.ec2_key_name
#     user_data = data.template_file.userdata.rendered
#     disable_api_termination = true

#     lifecycle {  ignore_changes = [ebs_block_device] }

#     root_block_device {
#         volume_type = "gp3"
#     }

#     ebs_block_device {
#         device_name = "/dev/sdf"
#         volume_size = 200
#     }

#     volume_tags = {
#         Name = "ec2-${var.aws_shot_region}-${var.environment}-monachain-orderer"
#     }

#     tags = {
#         Name = "ec2-${var.aws_shot_region}-${var.environment}-monachain-orderer"
#         Backup = "True"
#     }
# }

# resource "aws_instance" "monarest" {
#     ami                    = var.default_ami
#     instance_type          = var.monachain_instance_type
#     iam_instance_profile   = data.terraform_remote_state.comm.outputs.ec2_profile_id

#     vpc_security_group_ids = [aws_security_group.monachain_monarest_sg.id,aws_security_group.management_sg.id]

#     subnet_id              = data.terraform_remote_state.network.outputs.mona_subnets[0]
#     key_name               = data.terraform_remote_state.comm.outputs.ec2_key_name
#     user_data = data.template_file.userdata.rendered
#     disable_api_termination = true

#     lifecycle {  ignore_changes = [ebs_block_device] }

#     root_block_device {
#         volume_type = "gp3"
#     }

#     ebs_block_device {
#         device_name = "/dev/sdf"
#         volume_size = 100
#     }

#     volume_tags = {
#         Name = "ec2-${var.aws_shot_region}-${var.environment}-monachain-monarest"
#     }

#     tags = {
#         Name = "ec2-${var.aws_shot_region}-${var.environment}-monachain-monarest"
#         Backup = "True"
#     }  
# }

# resource "aws_instance" "monamgr" {
#     ami                    = var.default_ami
#     instance_type          = var.monachain_instance_type
#     iam_instance_profile   = data.terraform_remote_state.comm.outputs.ec2_profile_id

#     vpc_security_group_ids = [aws_security_group.monachain_monamgr_sg.id,aws_security_group.management_sg.id]

#     subnet_id              = data.terraform_remote_state.network.outputs.mona_subnets[0]
#     key_name               = data.terraform_remote_state.comm.outputs.ec2_key_name
#     user_data = data.template_file.userdata.rendered
#     disable_api_termination = true

#     lifecycle {  ignore_changes = [ebs_block_device] }

#     root_block_device {
#         volume_type = "gp3"
#     }

#     ebs_block_device {
#         device_name = "/dev/sdf"
#         volume_size = 100
#     }

#     volume_tags = {
#         Name = "ec2-${var.aws_shot_region}-${var.environment}-monachain-monamgr"
#     }

#     tags = {
#         Name = "ec2-${var.aws_shot_region}-${var.environment}-monachain-monamgr"
#         Backup = "True"
#     }  
# }

# resource "aws_instance" "monascan" {
#     ami                    = var.default_ami
#     instance_type          = var.monachain_instance_type
#     iam_instance_profile   = data.terraform_remote_state.comm.outputs.ec2_profile_id

#     vpc_security_group_ids = [aws_security_group.monachain_monascan_sg.id,aws_security_group.management_sg.id]

#     subnet_id              = data.terraform_remote_state.network.outputs.mona_subnets[0]
#     key_name               = data.terraform_remote_state.comm.outputs.ec2_key_name
#     user_data = data.template_file.userdata.rendered
#     disable_api_termination = true

#     lifecycle {  ignore_changes = [ebs_block_device] }

#     root_block_device {
#         volume_type = "gp3"
#     }

#     ebs_block_device {
#         device_name = "/dev/sdf"
#         volume_size = 100
#     }

#     volume_tags = {
#         Name = "ec2-${var.aws_shot_region}-${var.environment}-monachain-monascan"
#     }

#     tags = {
#         Name = "ec2-${var.aws_shot_region}-${var.environment}-monachain-monascan"
#         Backup = "True"
#     }
# }

resource "aws_instance" "publistner" {
    ami                    = var.default_ami
    instance_type          = var.monachain_instance_type
    iam_instance_profile   = data.terraform_remote_state.comm.outputs.ec2_profile_id

    vpc_security_group_ids = [aws_security_group.monachain_publistener_sg.id,aws_security_group.management_sg.id]

    subnet_id              = data.terraform_remote_state.network.outputs.mona_subnets[1]
    key_name               = data.terraform_remote_state.comm.outputs.ec2_key_name
    user_data = data.template_file.userdata.rendered
    disable_api_termination = true

    lifecycle {  ignore_changes = [ebs_block_device] }

    root_block_device {
        volume_type = "gp3"
    }

    ebs_block_device {
        device_name = "/dev/sdf"
        volume_size = 100
    }

    volume_tags = {
        Name = "ec2-${var.aws_shot_region}-${var.environment}-monachain-publistener"
    }

    tags = {
        Name = "ec2-${var.aws_shot_region}-${var.environment}-monachain-publistener"
        Backup = "True"
    }
}

resource "aws_instance" "solana" {
    ami                    = var.default_ami
    instance_type          = var.monachain_instance_type
    iam_instance_profile   = data.terraform_remote_state.comm.outputs.ec2_profile_id

    vpc_security_group_ids = [aws_security_group.monachain_solana_sg.id,aws_security_group.management_sg.id]

    subnet_id              = data.terraform_remote_state.network.outputs.mona_subnets[1]
    key_name               = data.terraform_remote_state.comm.outputs.ec2_key_name
    user_data = data.template_file.userdata.rendered
    disable_api_termination = true

    lifecycle {  ignore_changes = [ebs_block_device] }

    root_block_device {
        volume_type = "gp3"
    }

    ebs_block_device {
        device_name = "/dev/sdf"
        volume_size = 100
    }

    volume_tags = {
        Name = "ec2-${var.aws_shot_region}-${var.environment}-monachain-solana"
    }

    tags = {
        Name = "ec2-${var.aws_shot_region}-${var.environment}-monachain-solana"
        Backup = "True"
    }
}

resource "aws_instance" "ethereum" {
    ami                    = var.default_ami
    instance_type          = var.monachain_instance_type
    iam_instance_profile   = data.terraform_remote_state.comm.outputs.ec2_profile_id

    vpc_security_group_ids = [aws_security_group.monachain_ethereum_sg.id,aws_security_group.management_sg.id]

    subnet_id              = data.terraform_remote_state.network.outputs.mona_subnets[1]
    key_name               = data.terraform_remote_state.comm.outputs.ec2_key_name
    user_data = data.template_file.userdata.rendered
    disable_api_termination = true

    lifecycle {  ignore_changes = [ebs_block_device] }

    root_block_device {
        volume_type = "gp3"
    }

    ebs_block_device {
        device_name = "/dev/sdf"
        volume_size = 100
    }

    volume_tags = {
        Name = "ec2-${var.aws_shot_region}-${var.environment}-monachain-ethereum"
    }

    tags = {
        Name = "ec2-${var.aws_shot_region}-${var.environment}-monachain-ethereum"
        Backup = "True"
    }  
}