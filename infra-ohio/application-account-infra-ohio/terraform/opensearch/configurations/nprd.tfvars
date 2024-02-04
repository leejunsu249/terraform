##### Default Configuration #####
aws_region = "us-east-2"
aws_shot_region = "ue2"
environment = "nprd"
service_name = "naemo"
s3_tfstate_file = "opensearch.tfstate"
aws_account_number = 908317417455

##### opensearch #####
cluster_version = 1.3
instance_type = "m6g.large.elasticsearch"
instance_count = 2
availability_zone_count = 2
dedicated_master_enabled = false
subnet_ids = ["subnet-0696e1ee526abae1d", "subnet-06f465bd92c148b02"]
storage_options = [{ 
  ebs_enabled = true,
  volume_size = 100,
  volume_type = "gp3",
  iops = 3000
}]

##### cognito #####
cognito_name = "opensearch"
cognito_domain = "nprd-opensearch-naemo"

##### kinesis #####
log_stream_services = {
  ingress-nginx = {
    name = "ingress-nginx"
  },
  marketplace = {
    name = "marketplace"
  },
  metaverse = {
    name = "metaverse"
  },
  launchpadruntime = {
    name = "launchpadruntime"
  },
  metaverse = {
    name = "metaverse"
  },
  systemadmin = {
    name = "systemadmin"
  },
  notification = {
    name = "notification"
  },
  eth-middleware = {
    name = "eth-middleware"
  },
  eth-batch = {
    name = "eth-batch"
  },
  eth-block-confirmation = {
    name = "eth-block-confirmation"
  },
  sol-middleware = {
    name = "sol-middleware"
  },
  sol-batch = {
    name = "sol-batch"
  },
  sol-block-confirmation = {
    name = "sol-block-confirmation"
  },
  mona-chain = {
    name = "mona-chain"
  },
  wallet-ingress-nginx = {
    name = "wallet-ingress-nginx"
  },  
  bc-centralwallet = {
    name = "bc-centralwallet"
  },
  be-centralwallet = {
    name = "be-centralwallet"
  }
}

service_log_backup_bucket_name = "s3-an2-shd-naemo-service-logs"