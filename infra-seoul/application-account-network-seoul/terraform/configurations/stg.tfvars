##### Default Configuration #####
aws_region      = "ap-northeast-2"
aws_shot_region = "an2"
environment     = "stg"
service_name    = "naemo"
account_id      = "087942668956"
s3_tfstate_file = "network.tfstate"

##### Service #####
domain         = "mgmt.an2.stg.naemo.io"
feature_domain = ""

vpc_cidr            = "10.0.18.0/23"
vpc_secondary_cidrs = "100.64.26.0/23"

azs = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]

private_lb_subnets        = ["10.0.18.0/27", "10.0.18.32/27", "10.0.18.64/27"]
private_inner_subnets     = ["10.0.18.96/27", "10.0.18.128/27", "10.0.18.160/27"]
private_app_subnets       = ["10.0.19.0/27", "10.0.19.32/27", "10.0.19.64/27"]
private_db_subnets        = ["10.0.19.96/27", "10.0.19.128/27", "10.0.19.160/27"]
private_secondary_subnets = ["100.64.26.0/25", "100.64.26.128/25", "100.64.27.0/25"]

##### wallet #####
wallet_vpc_cidr            = "10.0.33.0/24"
wallet_vpc_secondary_cidrs = "100.64.32.0/23"

wallet_azs = ["ap-northeast-2a", "ap-northeast-2c"]

wallet_private_inner_subnets     = ["10.0.33.0/27", "10.0.33.32/27"]
wallet_private_lb_subnets        = ["10.0.33.64/27", "10.0.33.96/27"]
wallet_private_app_subnets       = ["10.0.33.128/27", "10.0.33.160/27"]
wallet_private_db_subnets        = ["10.0.33.192/27", "10.0.33.224/27"]
wallet_private_secondary_subnets = ["100.64.32.0/24", "100.64.33.0/24"]
