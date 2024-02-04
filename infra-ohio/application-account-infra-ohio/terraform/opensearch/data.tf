data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_default_tags" "current" {}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.environment}-ue2"
    key    = "${var.environment}/network.tfstate"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "comm" {
  backend = "s3"
  config = {
    bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.environment}-ue2"
    key    = "${var.environment}/comm.tfstate"
    region = "us-east-2"
  }
}
