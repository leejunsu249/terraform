##### Default Configuration #####
region         = "us-east-2"
aws_shot_region    = "ue2"
aws_an2_shot_region = "an2"
environment        = "dev"
an2_env            = "dev"
service_name       = "naemo"
aws_account_number = 385866877617
profile = "dev"

net_aws_region      = "us-east-2"
net_aws_shot_region = "ue2"
net_environment     = "net"
net_service_name    = "naemo"
net_profile = "net"

public_domain          = "naemo.io"
dev_bc_public_domain      = "dev-bc.naemo.io"
dev_new_public_domain = "dev-new.naemo.io"
domain                 = "mgmt.net.naemo.io"
marketplace_cognito_name = "naemo-marketplace-bc"
systemadmin_cognito_name = "naemo-systemadmin-bc"

wallet_service_name = "naemo-wallet"

secret_names     = [
    "market-bc"
  ]
secret_names_an2 = [
    "wallet-be-centralwallet-bc",
    "system-bc"
]


### ecr repo ##
repo_names     = [
    "be-centralwallet-bc",
    "be-launchpadruntime-bc",
    "be-marketplace-bc",
    "be-metaverse-bc",
    "be-notification-bc",
    "be-systemadmin-bc",
    "eth-batch-bc",
    "eth-block-confirmation-bc",
    "eth-middleware-bc",
    "fe-centralwallet-bc",
    "fe-systemadmin-bc",
    "sol-batch-bc",
    "sol-block-confirmation-bc",
    "sol-middleware-bc",
    "bc-centralwallet-polygon-bc",
    "be-kafka-bc",
    "polygon-batch-bc",
    "polygon-block-confirmation-bc",
    "polygon-middleware-bc",
    "common-middleware-bc",
    "be-creator-admin-bc",
    "polling-middleware-bc",
    "bc-centralwallet-bc"
  ]

kms_key_id = "aws/secretsmanager"

#### Unity ####
unity_s3_role_name = "arn:aws:iam::649631385617:role/S3-ReadOnly-Access"

#### s3 ####
cloudfront_marketplace_oai       = "E3MWZH5X4RK319"
cloudfront_creatoradmin_oai      = "E2EDZ736JZ5EDV"
cloudfront_marketplace_next_oai  = "E1VH95SBH8NBEU"
cloudfront_creatoradmin_next_oai = "E28VKXBB31MFH8"
cloudfront_marketplace_bc_oai = "E22H27EMTUEYZ9" # 사용하지 않음
cloudfront_creatoradmin_oai_bc     = "E15WHLI1NHJSD3" # 사용하지 않음

#### cognito #####
wallet_centralwallet_cognito_name = "naemo-centralwallet-bc"
wallet_systemadmin_cognito_name = "naemo-systemadmin-bc"

##### redis.tf #####
redis_global_replication = false
auth_redis_node_type     = "cache.t4g.medium"
session_redis_node_type  = "cache.t4g.medium"
redis_multi_az           = false
cluster_mode             = false
parameter = [
  {
    name  = "notify-keyspace-events"
    value = "Ex"
  },
  {
    name  = "slowlog-log-slower-than"
    value = "2000"
  },
  {
    name  = "slowlog-max-len"
    value = "1024"
  }
]
redis_password_spacial = true
eks_cluster_node_sg_id = "sg-03aa4c0ef519e2452"
kms_redis_arn = "arn:aws:kms:us-east-2:385866877617:key/8d5afbb1-bd00-430c-817f-d855c3b6d6f5"
vpc_id = "vpc-0ec00c71f4571c166"
subnet_id = ["subnet-00682d9b756c093e1","subnet-0f3720c30a64c4fe9"]

an2_eks_cluster_node_sg_id = "sg-018a10e5133c58e1b"
an2_kms_redis_arn = "arn:aws:kms:ap-northeast-2:385866877617:key/742411ae-132d-42c6-8d8b-41ef98a0eaab"
an2_vpc_id = "vpc-0d6b9b4ab6589820d"
an2_subnet_id = ["subnet-028193daa1088d385","subnet-05b149ab808a2c1c5"]