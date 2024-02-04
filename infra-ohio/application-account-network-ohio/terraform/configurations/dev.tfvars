aws_region         = "us-east-2"
aws_shot_region    = "ue2"
environment        = "dev"
service_name       = "naemo"
s3_tfstate_file    = "network.tfstate"
aws_account_number = 385866877617

domain         = "mgmt.dev.naemo.io"
feature_domain = "mgmt.feature.naemo.io"

vpc_cidr            = "10.0.4.0/23"
vpc_secondary_cidrs = ["100.64.0.0/21"]

azs = ["us-east-2a", "us-east-2b"]

private_lb_subnets    = ["10.0.4.0/27", "10.0.4.32/27"]
private_inner_subnets = ["10.0.5.64/27", "10.0.5.96/27"]
private_app_subnets   = ["10.0.4.64/26", "10.0.4.128/26"]
#private_mona_subnets = ["10.0.4.192/27", "10.0.4.224/27"]
private_db_subnets        = ["10.0.5.0/27", "10.0.5.32/27"]
private_secondary_subnets = ["100.64.0.0/22", "100.64.4.0/22"]
private_batch_subnets     = ["10.0.5.128/26", "10.0.5.192/26"]
private_monitor_subnets   = []
