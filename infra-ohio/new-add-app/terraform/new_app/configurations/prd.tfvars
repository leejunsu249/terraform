##### Default Configuration #####
region         = "us-east-2"
aws_shot_region    = "ue2"
aws_an2_shot_region    = "an2"
environment        = "prd"
env_nprd    = "nprd"
an2_env            = "prd"
service_name       = "naemo"
wallet_service_name   = "wallet"
aws_account_number = "908317417455"
profile = "prd"
ohio_eks_oid_app = "arn:aws:iam::908317417455:oidc-provider/oidc.eks.us-east-2.amazonaws.com/id/C2C487550EA9D6C6CBD6B7BFEA30A6B1"
ohio_eks_oid = "oidc.eks.us-east-2.amazonaws.com/id/C2C487550EA9D6C6CBD6B7BFEA30A6B1"
an2_eks_oid_app = "arn:aws:iam::908317417455:oidc-provider/oidc.eks.ap-northeast-2.amazonaws.com/id/C33F0C374C4B25AD37496D2B00DA4F9E"
an2_eks_oid = "oidc.eks.ap-northeast-2.amazonaws.com/id/C33F0C374C4B25AD37496D2B00DA4F9E"
s3_tfstate_file = "new_apps_terraform.tfstate"
s3_tfstate_dir = "prd"

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
holder_oid = "E133A5ODTL0BW5"
front_oid = "E3RO78R0C096MK"

log_stream_services = {
  creator-admin = {
    name = "creator-admin"
  },
  discord-middleware = {
    name = "discord-middleware"
  },
  bc-common-middleware = {
    name = "bc-common-middleware"
  },
  polling-middleware = {
    name = "polling-middleware"
  },
  be-queue = {
    name = "be-queue"
  },
  scheduler = {
    name = "scheduler"
  }   

}

elasticsearch_domain_arn       = "arn:aws:es:us-east-2:908317417455:domain/opensearch-ue2-nprd-naemo"
firehose_opensearch_role_arn   = "arn:aws:iam::908317417455:role/firehose-opensearch-role"
subnet_ids = ["subnet-0696e1ee526abae1d", "subnet-06f465bd92c148b02"]
aws_security_group_opensearch  = "sg-06a6df69570f77c6a"
service_log_backup_bucket_name = "s3-an2-shd-naemo-service-logs"
