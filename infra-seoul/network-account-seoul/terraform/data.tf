data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.environment}-ue2"
    key    = "${var.environment}/network.tfstate"
    region = "us-east-2"
  }
}

data "aws_caller_identity" "current" {}
