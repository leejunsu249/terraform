##### Default Configuration #####
aws_region      = "ap-northeast-2"
aws_shot_region = "an2"
environment     = "prd"
service_name    = "naemo"
account_id      = "908317417455"
s3_tfstate_file = "network.tfstate"

##### Service #####
domain         = "mgmt.an2.prd.naemo.io"
feature_domain = ""

vpc_cidr            = "10.0.20.0/23"
vpc_secondary_cidrs = "100.64.28.0/23"

azs = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]

private_lb_subnets        = ["10.0.20.0/27", "10.0.20.32/27", "10.0.20.64/27"]
private_inner_subnets     = ["10.0.20.96/27", "10.0.20.128/27", "10.0.20.160/27"]
private_app_subnets       = ["10.0.21.0/27", "10.0.21.32/27", "10.0.21.64/27"]
private_db_subnets        = ["10.0.21.96/27", "10.0.21.128/27", "10.0.21.160/27"]
private_secondary_subnets = ["100.64.28.0/25", "100.64.28.128/25", "100.64.29.0/25"]

##### wallet #####
wallet_vpc_cidr            = "10.0.34.0/24"
wallet_vpc_secondary_cidrs = "100.64.34.0/23"

wallet_azs = ["ap-northeast-2a", "ap-northeast-2c"]

wallet_private_inner_subnets     = ["10.0.34.0/27", "10.0.34.32/27"]
wallet_private_lb_subnets        = ["10.0.34.64/27", "10.0.34.96/27"]
wallet_private_app_subnets       = ["10.0.34.128/27", "10.0.34.160/27"]
wallet_private_db_subnets        = ["10.0.34.192/27", "10.0.34.224/27"]
wallet_private_secondary_subnets = ["100.64.34.0/24", "100.64.35.0/24"]
