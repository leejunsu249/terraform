##### Default Configuration #####
aws_region = "us-east-2"
aws_shot_region = "ue2"
environment = "nprd"
an2_env = "prd"
service_name = "naemo" 
s3_tfstate_file = "eks.tfstate"
aws_account_number = 908317417455

# eks.tf
eks_node_instance_types = ["c6i.large"]
capacity_type = "ON_DEMAND"
log_group_retention = 30

management_bottlerocket_node = {
  min_size       = 0,
  max_size       = 4,
  instance_types = ["c6i.large"]
}

marketplace_bottlerocket_node = {
  min_size       = 0,
  max_size       = 6,
  instance_types = ["c6i.xlarge"]
}

launchpad_bottlerocket_node = {
  min_size       = 0,
  max_size       = 4,
  instance_types = ["c6i.xlarge"]
}

metaverse_bottlerocket_node = {
  min_size       = 0,
  max_size       = 2,
  instance_types = ["c6i.xlarge"]
}

middleware_bottlerocket_node = {
  min_size       = 0,
  max_size       = 4,
  instance_types = ["c6i.4xlarge"]
}

common_bottlerocket_node = {
  min_size       = 0,
  max_size       = 4,
  instance_types = ["c6i.xlarge"]
}

batch_bottlerocket_node = {
  min_size       = 0,
  max_size       = 2,
  instance_types = ["c6i.xlarge"]
}

#### Worker Node Spec Change ####
management_bottlerocket_node_v2 = {
  min_size       = 2,
  max_size       = 4,
  instance_types = ["c6i.large"]
}

marketplace_bottlerocket_node_v2 = {
  min_size = 2,
  max_size = 6
  instance_types = ["c6i.xlarge"]
}

launchpad_bottlerocket_node_v2 = {
  min_size = 2,
  max_size = 4,
  instance_types = ["c6i.xlarge"]
}

metaverse_bottlerocket_node_v2 = {
  desired_size = 0
  min_size = 0,
  max_size = 2,
  instance_types = ["c6i.xlarge"]
}

# 버전 업데이트 시에 스펙 변경 할 수 있음
# 기존 c6i.4xlarge -> c6i.2xlarge
middleware_bottlerocket_node_v2 = {
  min_size = 4,
  max_size = 8,
  instance_types = ["c6i.2xlarge"]
}

common_bottlerocket_node_v2 = {
  min_size = 2,
  max_size = 4
  instance_types = ["c6i.xlarge"]
}

batch_bottlerocket_node_v2 = {
  min_size = 1,
  max_size = 2,
  instance_types = ["c6i.xlarge"]
}
## Worker Node Spec Change true : false 
common_worker_spec_change = true
market_worker_spec_change = false
batch_worker_spec_change = true
