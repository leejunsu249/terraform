##### Default Configuration #####
aws_region         = "ap-northeast-2"
aws_shot_region    = "an2"
environment        = "stg"
ue2_env            = "stg"
wallet_service_name = "naemo-wallet"
s3_tfstate_file    = "eks.tfstate"
aws_account_number = 087942668956

# eks.tf
eks_node_instance_types = ["t3.large"]
capacity_type           = "ON_DEMAND"
log_group_retention = 1

management_bottlerocket_node = {
  min_size       = 0,
  max_size       = 2,
  desired_size   = 0,
  instance_types = ["t3.large"]
}

manage_bottlerocket_node_v2 = {
  min_size       = 2,
  max_size       = 2,
  desired_size   = 2,
  instance_types = ["t3.large"]
}

central_wallet_bottlerocket_node = {
  min_size       = 0,
  max_size       = 2,
  desired_size   = 0,
  instance_types = ["t3a.xlarge"]
}

central_wallet_bottlerocket_node_v2 = {
  min_size       = 1,
  max_size       = 2,
  desired_size   = 2,
  instance_types = ["t3a.xlarge"]
}

backoffice_bottlerocket_node = {
  min_size       = 0,
  max_size       = 2,
  desired_size   = 0,
  instance_types = ["t3a.xlarge"]
}

b_office_bottlerocket_node_v2 = {
  min_size       = 1,
  max_size       = 2,
  desired_size   = 1,
  instance_types = ["t3a.xlarge"]
}

vpn_cidr = "192.168.1.0/24"

cluster_encryption_policy = "arn:aws:iam::087942668956:policy/eks-node-role-ClusterEncryption20220528051955814900000004"