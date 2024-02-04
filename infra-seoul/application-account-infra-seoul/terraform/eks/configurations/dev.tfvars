##### Default Configuration #####
aws_region         = "ap-northeast-2"
aws_shot_region    = "an2"
environment        = "dev"
ue2_env = "dev"
wallet_service_name = "naemo-wallet"
s3_tfstate_file    = "eks.tfstate"
aws_account_number = 385866877617

# eks.tf
eks_node_instance_types = ["t3.large"]
capacity_type           = "ON_DEMAND"
log_group_retention = 1

management_bottlerocket_node = {
  min_size       = 0,
  max_size       = 1,
  desired_size   = 0,
  instance_types = ["t3.large"]
}

manage_bottlerocket_node_v2 = {
  min_size       = 1,
  max_size       = 2,
  desired_size   = 1,
  instance_types = ["t3.large"]
}

central_wallet_bottlerocket_node = {
  min_size       = 0,
  max_size       = 1,
  desired_size   = 0,
  instance_types = ["t3.xlarge"]
}

central_wallet_bottlerocket_node_v2 = {
  min_size       = 1,
  max_size       = 4,
  desired_size   = 1,
  instance_types = ["t3.xlarge"]
}

backoffice_bottlerocket_node = {
  min_size       = 0,
  max_size       = 2,
  desired_size   = 0,
  instance_types = ["t3.xlarge"]
}

b_office_bottlerocket_node_v2 = {
  min_size       = 1,
  max_size       = 2,
  desired_size   = 1,
  instance_types = ["t3.xlarge"]
}

feature_bottlerocket_node = {
  min_size       = 1,
  max_size       = 4,
  desired_size   = 1,
  instance_types = ["t3.xlarge"]
}

vpn_cidr = "192.168.1.0/24"

cluster_encryption_policy = "arn:aws:iam::385866877617:policy/eks-node-role-ClusterEncryption20220410231918195200000001"

## Worker Node Spec Change true : false 
management_worker_spec_change = false
central_wallet_worker_spec_change = false
backoffice_worker_spec_change = false
feature_worker_spec_change = false
version_update = false