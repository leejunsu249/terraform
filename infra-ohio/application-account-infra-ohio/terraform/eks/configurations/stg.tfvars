##### Default Configuration #####
aws_region = "us-east-2"
aws_shot_region = "ue2"
environment = "stg"
an2_env = "stg"
service_name = "naemo"
s3_tfstate_file = "eks.tfstate"
aws_account_number = 087942668956

# eks.tf 
eks_node_instance_types = ["m6i.large"]
capacity_type = "ON_DEMAND"
log_group_retention = 5

## 스펙 변경 해야함 medium 5 > large 2  
management_bottlerocket_node = {
  min_size       = 0,
  max_size       = 5,
  instance_types = ["t3.medium"]
}

marketplace_bottlerocket_node = {
  min_size       = 0,
  max_size       = 4,
  instance_types = ["c6i.xlarge"]
}

launchpad_bottlerocket_node = {
  min_size = 0,
  max_size = 2,
  instance_types = ["c6i.xlarge"]
}

metaverse_bottlerocket_node = {
  desired_size = 0
  min_size = 0,
  max_size = 2,
  instance_types = ["c6i.xlarge"]
}

middleware_bottlerocket_node = {
  min_size = 0,
  max_size = 6
  instance_types = ["c6i.xlarge"]
}

common_bottlerocket_node = {
  min_size = 0,
  max_size = 2
  instance_types = ["c6i.xlarge"]
}

batch_bottlerocket_node = {
  min_size = 0,
  max_size = 2
  instance_types = ["c6i.large"]
}

#### Worker Node Spec Change ####
management_bottlerocket_node_v2 = {
  min_size       = 2,
  max_size       = 4,
  instance_types = ["t3.large"]
}

marketplace_bottlerocket_node_v2 = {
  min_size       = 1,
  max_size       = 4,
  instance_types = ["c6i.xlarge"]
}

launchpad_bottlerocket_node_v2 = {
  min_size = 1,
  max_size = 2,
  instance_types = ["c6i.xlarge"]
}

metaverse_bottlerocket_node_v2 = {
  desired_size = 0
  min_size = 0,
  max_size = 2,
  instance_types = ["c6i.xlarge"]
}

middleware_bottlerocket_node_v2 = {
  min_size = 3,
  max_size = 6
  instance_types = ["c6i.xlarge"]
}

common_bottlerocket_node_v2 = {
  min_size = 1,
  max_size = 2
  instance_types = ["c6i.xlarge"]
}

batch_bottlerocket_node_v2 = {
  min_size = 1,
  max_size = 2
  instance_types = ["c6i.large"]
}
## Worker Node Spec Change true : false 
common_worker_spec_change = false
market_worker_spec_change = false
