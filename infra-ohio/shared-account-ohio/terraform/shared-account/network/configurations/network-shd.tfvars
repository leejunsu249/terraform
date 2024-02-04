aws_region = "us-east-2"
aws_region_shot = "ue2"

azs = ["us-east-2a", "us-east-2b"]

environment = "shd"
service_name = "shd"

domain = "mgmt.shd.naemo.io"

vpc_cidr = "10.0.14.0/23"

private_lb_sub_1_cidr = "10.0.14.0/26"
private_lb_sub_2_cidr = "10.0.14.64/26"
private_app_sub_1_cidr = "10.0.15.0/25"
private_app_sub_2_cidr = "10.0.15.128/25"
private_inner_sub_1_cidr = "10.0.14.128/27"
private_inner_sub_2_cidr = "10.0.14.160/27"
