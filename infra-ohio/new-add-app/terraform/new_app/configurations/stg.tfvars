##### Default Configuration #####
region         = "us-east-2"
aws_shot_region    = "ue2"
aws_an2_shot_region    = "an2"
environment        = "stg"
an2_env            = "stg"
service_name       = "naemo"
wallet_service_name   = "wallet"
aws_account_number = "087942668956"
profile = "stg"
ohio_eks_oid_app = "arn:aws:iam::087942668956:oidc-provider/oidc.eks.us-east-2.amazonaws.com/id/E1590B0C4B7CF0087E8224BE91AFDECA"
ohio_eks_oid = "oidc.eks.us-east-2.amazonaws.com/id/E1590B0C4B7CF0087E8224BE91AFDECA"
an2_eks_oid_app = "arn:aws:iam::087942668956:oidc-provider/oidc.eks.ap-northeast-2.amazonaws.com/id/F0FD857663A5804DA13E426623D8E405"
an2_eks_oid = "oidc.eks.ap-northeast-2.amazonaws.com/id/F0FD857663A5804DA13E426623D8E405"
s3_tfstate_file = "new_apps_terraform.tfstate"
s3_tfstate_dir = "stg"



### ecr repo ##
repo_names     = [
    "polling-middleware",
    "be-creator-admin",
    "discord-middleware",
     "common-middleware",
     "bc-centralwallet-polygon",
     "polygon-batch",
     "polygon-block-confirmation",
     "polygon-middleware",
     "be-app-admin",
     "be-scheduler",
     "be-queue",
     "be-poll-community",
     "be-reward"
  ]

secret_names     = [
    "polling-middle",
    "bc-common-middleware",
    "creator-admin",
    "polygon_midapp",
    "polygon_midbatch",
    "be-scheduler",
    "be-queue",
    "launch_marketapp",
    "poll-community",
    "reward"    
  ]

secret_config = [
    "sol_middleware",
    "discord_middleware",
    "polygon_middleware",
    "polygon_batch",
    "polygon_block_confirmation"
  ]

  wallet_secret_names = []
  wallet_secret_config = ["bc-centralwallet-polygon"]

kms_key_id = "aws/secretsmanager"
holder_oid = "E6TGHE3EM8Q48"
front_oid = "E3EC6YBPCC5JVA"