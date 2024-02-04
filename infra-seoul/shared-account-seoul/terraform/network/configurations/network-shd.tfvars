aws_region      = "ap-northeast-2"
aws_region_shot = "an2"

azs = ["ap-northeast-2a", "ap-northeast-2c"]

environment  = "shd"
service_name = "shd"

domain = "mgmt.an2.shd.naemo.io"

vpc_cidr = "10.0.22.0/23"

private_lb_sub_1_cidr    = "10.0.22.0/26"
private_lb_sub_2_cidr    = "10.0.22.64/26"
private_app_sub_1_cidr   = "10.0.23.0/25"
private_app_sub_2_cidr   = "10.0.23.128/25"
private_inner_sub_1_cidr = "10.0.22.128/27"
private_inner_sub_2_cidr = "10.0.22.160/27"
