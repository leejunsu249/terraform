##### Default Configuration #####
aws_region = "us-east-2"
aws_shot_region = "ue2"
environment = "dev"
an2_env = "dev"
service_name = "naemo"
s3_tfstate_file = "eks.tfstate"
aws_account_number = 385866877617

# eks.tf
eks_node_instance_types = ["t3.xlarge"]
capacity_type = "ON_DEMAND"
log_group_retention = 1

management_bottlerocket_node = {
  min_size       = 0,
  max_size       = 2
  instance_types = ["t3.large"]
}

marketplace_bottlerocket_node = {
  min_size       = 0,
  max_size       = 4
  instance_types = ["t3.xlarge"]
}

feature_bottlerocket_node = {
  min_size       = 1,
  max_size       = 2,
  instance_types = ["t3.xlarge"]
}

middleware_bottlerocket_node = {
    min_size = 0,
    max_size = 3
    instance_types = ["t3.xlarge"]
}

#### Worker Node Spec Change ####
management_bottlerocket_node_v2 = {
  min_size       = 2,
  max_size       = 2,
  instance_types = ["t3.large"]
}

marketplace_bottlerocket_node_v2 = {
  min_size = 3,
  max_size = 4
  instance_types = ["t3.xlarge"]
}

middleware_bottlerocket_node_v2 = {
    min_size = 2,
    max_size = 3,
    instance_types = ["t3.xlarge"]
}

# feature_bottlerocket_node_v2 = {
#   min_size       = 1,
#   max_size       = 2,
#   instance_types = ["t3.xlarge"]
# }


## Worker Node Spec Change true : false 
common_worker_spec_change = false
market_worker_spec_change = true
launchpad_worker_spec_change = false
metaverse_worker_spec_change = false
version_update = false
