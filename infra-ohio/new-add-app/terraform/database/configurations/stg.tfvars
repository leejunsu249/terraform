##### Default Configuration #####
region         = "us-east-2"
aws_shot_region    = "ue2"
environment        = "stg"
an2_env            = "stg"
service_name       = "naemo"
aws_account_number = 087942668956
s3_tfstate_file = "databases_terraform.tfstate"
s3_tfstate_dir = "stg"

##### redis.tf #####
redis_global_replication = false
auth_redis_node_type     = "cache.t4g.medium"
session_redis_node_type  = "cache.t4g.medium"
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
eks_cluster_node_sg_id = "sg-07f17cfe78c8dc55d"
manage_sg = "sg-0d59449d66c15fa5d"
kms_redis_arn = "arn:aws:kms:us-east-2:087942668956:key/8c22c19a-ecf5-40df-9e57-38983d85b68c"
vpc_id = "vpc-0954107e677c2fbd6"
redis_subnet_group = "rsg-ue2-stg-naemo"
wallet_app_cidr = ["10.0.33.128/27","10.0.33.160/27"]
