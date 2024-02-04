##### Default Configuration #####
aws_region = "us-east-2"
aws_shot_region = "ue2"
environment = "prd"
service_name = "naemo" 
s3_tfstate_file = "eks.tfstate"
aws_account_number = 908317417455

# eks.tf
eks_node_instance_types = ["c6i.large"]
capacity_type = "ON_DEMAND"
log_group_retention = 30

management_bottlerocket_node = {
  min_size       = 2,
  max_size       = 4,
  instance_types = ["c6i.large"]
}

marketplace_bottlerocket_node = {
  min_size       = 4,
  max_size       = 10,
  instance_types = ["c6i.2xlarge"]
}

launchpad_bottlerocket_node = {
  min_size = 2,
  max_size = 4,
  instance_types = ["c6i.xlarge"]
}

metaverse_bottlerocket_node = {
  min_size = 0,
  max_size = 0,
  instance_types = ["c6i.xlarge"]
}

middleware_bottlerocket_node = {
  min_size = 2,
  max_size = 4,
  instance_types = ["c6i.2xlarge"]
}