aws_region         = "us-east-2"
aws_shot_region    = "ue2"
environment        = "prd"
service_name       = "naemo"
s3_tfstate_file    = "network.tfstate"
aws_account_number = 908317417455

domain = "mgmt.prd.naemo.io"

vpc_cidr            = "10.0.8.0/23"
vpc_secondary_cidrs = ["100.64.16.0/21"]

azs = ["us-east-2a", "us-east-2b"]

private_lb_subnets        = ["10.0.8.0/27", "10.0.8.32/27"]
private_inner_subnets     = ["10.0.8.64/27", "10.0.8.96/27"]
private_app_subnets       = ["10.0.9.0/26", "10.0.9.64/26"]
private_db_subnets        = ["10.0.9.128/26", "10.0.9.192/26"]
private_secondary_subnets = ["100.64.16.0/22", "100.64.20.0/22"]
private_batch_subnets     = ["10.0.8.128/26", "10.0.8.192/26"]
#private_mona_subnets = []
private_monitor_subnets = []
