data "terraform_remote_state" "comm" {
  backend = "s3"
  config = {
    bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.environment}-${var.aws_shot_region}"
    key    = "${var.environment}/comm.tfstate"
    region = "${var.aws_region}"
  }
}

data "terraform_remote_state" "comm_ue2" {
  backend = "s3"
  config = {
    bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.ue2_env}-ue2"
    key    = "${var.ue2_env}/comm.tfstate"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.environment}-${var.aws_shot_region}"
    key    = "${var.environment}/network.tfstate"
    region = "${var.aws_region}"
  }
}

data "terraform_remote_state" "network_ue2" {
  backend = "s3"
  config = {
    bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.ue2_env}-ue2"
    key    = "${var.ue2_env}/network.tfstate"
    region = "us-east-2"
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_default_tags" "current" {}


