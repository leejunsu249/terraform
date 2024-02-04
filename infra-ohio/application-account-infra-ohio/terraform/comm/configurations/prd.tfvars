##### Default Configuration #####
aws_region         = "us-east-2"
aws_shot_region    = "ue2"
environment        = "prd"
service_name       = "naemo"
s3_tfstate_file    = "comm.tfstate"
aws_account_number = 908317417455

##### ecr.tf #####
notification_ecr_name           = "be-notification"
marketplace_ecr_name            = "be-marketplace"
systemadmin_be_ecr_name         = "be-systemadmin"
systemadmin_fe_ecr_name         = "fe-systemadmin"
centralwallet_fe_ecr_name       = "fe-centralwallet"
centralwallet_be_ecr_name       = "be-centralwallet"
feature_ecr_name                = "feature-image"
launchpadruntime_ecr_name       = "be-launchpadruntime"
metaverse_ecr_name              = "be-metaverse"
eth_middleware_ecr_name         = "eth-middleware"
eth_batch_ecr_name              = "eth-batch"
eth_block_confirmation_ecr_name = "eth-block-confirmation"
sol_middleware_ecr_name         = "sol-middleware"
sol_batch_ecr_name              = "sol-batch"
sol_block_confirmation_ecr_name = "sol-block-confirmation"
bc_centralwallet_ecr_name       = "bc-centralwallet"
blockchain_cache_ecr_name       = "blockchain_cache"
kafka_ecr_name                  = "be-kafka"

#### service #####
ec2_keypair_name  = "ec2-key"
lena_keypair_name = "lena-key"
tuna_keypair_name = "tuna-key"

#### cognito #####
marketplace_cognito_name = "naemo-marketplace"
systemadmin_cognito_name = "naemo-systemadmin"

#### ec2 ####
common_ami           = "ami-08e5d40c2c48baffc" // common ami
lena_instance_type   = "c6i.large"
tuna_instance_type   = "c6i.xlarge"
search_instance_type = "m6i.large"

#### s3 ####
cloudfront_marketplace_oai  = "E3RO78R0C096MK"
cloudfront_creatoradmin_oai = "E2GNVY3PVEN4FA"
cloudfront_homepage_oai     = "E20G3BJV7K1Z3K"
s3_vpce_gw                  = "vpce-006605756b83e33fd"

#### Unity ####
unity_s3_role_name = "arn:aws:iam::649382143802:role/S3-ReadOnly-Access"

vpn_cidr = "192.168.1.0/24"
