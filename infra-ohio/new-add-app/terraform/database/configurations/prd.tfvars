##### Default Configuration #####
region         = "us-east-2"
aws_shot_region    = "ue2"
environment        = "nprd"
an2_env            = "prd"
service_name       = "naemo"
aws_account_number = 908317417455
s3_tfstate_file = "databases_terraform.tfstate"
s3_tfstate_dir = "prd"


##### redis.tf #####
redis_global_replication = false
auth_redis_node_type     = "cache.r6g.large"
session_redis_node_type  = "cache.r6g.large"
redis_multi_az           = true
cluster_mode             = true
parameter = [
  {
    name  = "notify-keyspace-events"
    value = "Ex"
  },
  {
    name  = "slowlog-log-slower-than"
    value = "2000"
  },
  {
    name  = "slowlog-max-len"
    value = "1024"
  }
]
redis_password_spacial = false
eks_cluster_node_sg_id = "sg-029aafd34e1d8dca3"
manage_sg = "sg-0be2bedfa8d9bcc8f"
kms_redis_arn = "arn:aws:kms:us-east-2:908317417455:key/33efb73c-c995-4c78-b8aa-48f109ff87b2"
vpc_id = "vpc-090b3471ac7efa7b8"
redis_subnet_group = "rsg-ue2-nprd-naemo"
wallet_app_cidr = ["10.0.34.128/27","10.0.34.160/27"]
