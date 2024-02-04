##### Default Configuration #####
region         = "us-east-2"
aws_shot_region    = "ue2"
aws_an2_shot_region    = "an2"
environment        = "dev"
an2_env            = "dev"
service_name       = "naemo"
wallet_service_name   = "wallet"
aws_account_number = 385866877617
profile = "dev"
ohio_eks_oid_app = "arn:aws:iam::385866877617:oidc-provider/oidc.eks.us-east-2.amazonaws.com/id/180B1FF96E136F77917606EE7A630C9F"
ohio_eks_oid = "oidc.eks.us-east-2.amazonaws.com/id/180B1FF96E136F77917606EE7A630C9F"
an2_eks_oid_app = "arn:aws:iam::385866877617:oidc-provider/oidc.eks.ap-northeast-2.amazonaws.com/id/58FF8B1C1E9B7EAE9583D1DA93AE710A"
an2_eks_oid = "oidc.eks.ap-northeast-2.amazonaws.com/id/58FF8B1C1E9B7EAE9583D1DA93AE710A"
s3_tfstate_file = "new_apps_terraform.tfstate"
s3_tfstate_dir = "dev"


### ecr repo ##
repo_names     = [
    "polling-middleware",
    "be-creator-admin",
    "discord-middleware",
    "common-middleware",
    "be-openapi",
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
    "be-scheduler",
    "be-queue",
    "launch_marketapp",
    "poll-community",
    "reward"
  ]

secret_config = [
    "sol_middleware",
    "discord_middleware"
  ]
wallet_secret_names = []
wallet_secret_config = ["bc-centralwallet-polygon"]

kms_key_id = "aws/secretsmanager"
holder_oid = "EJ5LK0PXF37ZU"
front_oid = "E1VH95SBH8NBEU"


