##### Default Configuration #####
aws_region = "us-east-2"
aws_shot_region = "ue2"
environment = "prd"
service_name = "naemo"
s3_tfstate_file = "opensearch.tfstate"
aws_account_number = 908317417455

##### opensearch #####
cluster_version = 1.3
instance_type = "m6g.large.elasticsearch"
instance_count = 2
availability_zone_count = 2
dedicated_master_enabled = false
subnet_ids = ["subnet-0399b599408660377", "subnet-0e3b5dc7a4145dd83"]
storage_options = [{ 
  ebs_enabled = true,
  volume_size = 50,
  volume_type = "gp3",
  iops = 3000
}]

##### cognito #####
cognito_name = "opensearch"
cognito_domain = "opensearch-naemo"

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
  }
}
service_log_backup_bucket_name = "s3-an2-shd-naemo-service-logs"