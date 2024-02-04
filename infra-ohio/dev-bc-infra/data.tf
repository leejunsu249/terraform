# data "terraform_remote_state" "comm" {
#   backend = "s3"
#   config = {
#     bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.environment}-ue2"
#     key    = "${var.environment}/comm.tfstate"
#     region = "us-east-2"
#     profile = "dev"
#   }
# }

# data "terraform_remote_state" "network" {
#   backend = "s3"
#   config = {
#     bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.environment}-ue2"
#     key    = "${var.environment}/network.tfstate"
#     region = "us-east-2"
#     profile = "dev"
#   }
# }

# data "terraform_remote_state" "network_an2" {
#   backend = "s3"
#   config = {
#     bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.an2_env}-an2"
#     key    = "${var.an2_env}/network.tfstate"
#     region = "ap-northeast-2"
#     profile = "dev"
#   }
# }

# data "terraform_remote_state" "eks" {
#   backend = "s3"
#   config = {
#     bucket = "${data.aws_caller_identity.current.account_id}-terraform-state-${var.environment}-ue2"
#     key    = "${var.environment}/eks.tfstate"
#     region = "us-east-2"
#     profile = "dev"
#   }
# }

# data "aws_region" "current" {}

# data "aws_caller_identity" "current" {}

# data "aws_default_tags" "current" {}

# data "aws_kms_key" "rds" {
#   key_id = "alias/aws/rds"
# }
