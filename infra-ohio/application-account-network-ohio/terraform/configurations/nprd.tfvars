aws_region         = "us-east-2"
aws_shot_region    = "ue2"
environment        = "nprd"
service_name       = "naemo"
s3_tfstate_file    = "network.tfstate"
aws_account_number = 908317417455

domain = "mgmt.nprd.naemo.io"

vpc_cidr            = "10.0.12.0/22"
vpc_secondary_cidrs = ["100.64.40.0/21"]

azs = ["us-east-2a", "us-east-2b"]

private_lb_subnets        = ["10.0.12.0/27", "10.0.12.32/27"]
private_inner_subnets     = ["10.0.12.64/27", "10.0.12.96/27"]
private_app_subnets       = ["10.0.13.0/26", "10.0.13.64/26"]
private_db_subnets        = ["10.0.13.128/26", "10.0.13.192/26"]
private_secondary_subnets = ["100.64.40.0/22", "100.64.44.0/22"]
private_batch_subnets     = ["10.0.12.128/26", "10.0.12.192/26"]
#private_mona_subnets      = []
private_monitor_subnets = ["10.0.14.0/26", "10.0.14.64/26"]
