##### Default Configuration #####
aws_region         = "ap-northeast-2"
aws_shot_region    = "an2"
environment        = "prd"
ue2_env            = "nprd"
wallet_service_name = "naemo-wallet"
s3_tfstate_file    = "eks.tfstate"
aws_account_number = 908317417455

# eks.tf
eks_node_instance_types = ["c6i.large"]
capacity_type           = "ON_DEMAND"
log_group_retention = 30

management_bottlerocket_node = {
  min_size       = 0,
  max_size       = 5,
  desired_size   = 0,
  instance_types = ["c6i.large"]
}

manage_bottlerocket_node_v2 = {
  min_size       = 2,
  max_size       = 5,
  desired_size   = 2,
  instance_types = ["c6i.large"]
}

central_wallet_bottlerocket_node = {
  min_size       = 0,
  max_size       = 4,
  desired_size   = 0,
  instance_types = ["c6i.2xlarge"]
}

central_wallet_bottlerocket_node_v2 = {
  min_size       = 2,
  max_size       = 4,
  desired_size   = 2,
  instance_types = ["c6i.2xlarge"]
}

backoffice_bottlerocket_node = {
  min_size       = 0,
  max_size       = 5,
  desired_size   = 0,
  instance_types = ["c6i.xlarge"]
}

b_office_bottlerocket_node_v2 = {
  min_size       = 2,
  max_size       = 5,
  desired_size   = 2,
  instance_types = ["c6i.xlarge"]
}

vpn_cidr = "192.168.1.0/24"
cluster_encryption_policy = "arn:aws:iam::908317417455:policy/eks-nprd-node-role-ClusterEncryption20221003064050753900000001"