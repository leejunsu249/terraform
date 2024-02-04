##### Default Configuration #####
aws_region      = "ap-northeast-2"
aws_shot_region = "an2"
environment     = "dev"
service_name    = "naemo"
account_id      = "385866877617"
s3_tfstate_file = "network.tfstate"

##### Service #####
domain         = "mgmt.an2.dev.naemo.io"
feature_domain = "mgmt.an2.feature.naemo.io"

vpc_cidr            = "10.0.17.0/24"
vpc_secondary_cidrs = "100.64.24.0/24"

azs = ["ap-northeast-2a", "ap-northeast-2c"]

private_inner_subnets     = ["10.0.17.0/27", "10.0.17.32/27"]
private_app_subnets       = ["10.0.17.64/27", "10.0.17.96/27"]
private_db_subnets        = ["10.0.17.128/27", "10.0.17.160/27"]
private_lb_subnets        = ["10.0.17.192/27", "10.0.17.224/27"]
private_secondary_subnets = ["100.64.24.0/25", "100.64.24.128/25"]

##### wallet #####
wallet_vpc_cidr            = "10.0.32.0/24"
wallet_vpc_secondary_cidrs = "100.64.30.0/23"

wallet_azs = ["ap-northeast-2a", "ap-northeast-2c"]

wallet_private_inner_subnets     = ["10.0.32.0/27", "10.0.32.32/27"]
wallet_private_lb_subnets        = ["10.0.32.64/27", "10.0.32.96/27"]
wallet_private_app_subnets       = ["10.0.32.128/27", "10.0.32.160/27"]
wallet_private_db_subnets        = ["10.0.32.192/27", "10.0.32.224/27"]
wallet_private_secondary_subnets = ["100.64.30.0/24", "100.64.31.0/24"]
