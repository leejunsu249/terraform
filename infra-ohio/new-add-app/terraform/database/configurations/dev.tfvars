##### Default Configuration #####
region         = "us-east-2"
aws_shot_region    = "ue2"
environment        = "dev"
an2_env            = "dev"
service_name       = "naemo"
aws_account_number = 385866877617
s3_tfstate_file = "databases_terraform.tfstate"
s3_tfstate_dir = "dev"

##### redis.tf #####
redis_global_replication = false
auth_redis_node_type     = "cache.t4g.medium"
session_redis_node_type  = "cache.t4g.medium"
redis_multi_az           = false
cluster_mode             = false
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
redis_password_spacial = true
eks_cluster_node_sg_id = "sg-03aa4c0ef519e2452"
manage_sg = "sg-0ba81f03eda4102ec"
kms_redis_arn = "arn:aws:kms:us-east-2:385866877617:key/8d5afbb1-bd00-430c-817f-d855c3b6d6f5"
vpc_id = "vpc-0ec00c71f4571c166"
redis_subnet_group = "rsg-ue2-dev-naemo"
wallet_app_cidr = ["10.0.32.128/27","10.0.32.160/27"]

#subnet_id = ["subnet-00682d9b756c093e1","subnet-0f3720c30a64c4fe9"]