# data "terraform_remote_state" "net-network" {
#   backend = "s3"
#   config = {
#     bucket = "351894368755-terraform-state-net-ue2"
#     key    = "net/network.tfstate"
#     region = "us-east-2"
# #    role_arn = ""
#   }
# }

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "385866877617-terraform-state-${var.environment}-ue2"
    key    = "${var.environment}/network.tfstate"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "comm" {
  backend = "s3"
  config = {
    bucket = "385866877617-terraform-state-${var.environment}-ue2"
    key    = "${var.environment}/comm.tfstate"
    region = "us-east-2"
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_default_tags" "current" {}

data "aws_kms_key" "rds" {
  key_id = "alias/aws/rds"
}

data "template_file" "userdata" {
  template = "${file("script/user_data.sh")}"
  vars = {
    bcs_keypair = "${tls_private_key.monachain_private_key.public_key_openssh}"
  }
}