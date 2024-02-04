##### Default Configuration #####
aws_region          = "ap-northeast-2"
aws_shot_region     = "an2"
environment         = "stg"
service_name        = "naemo"
wallet_service_name = "naemo-wallet"
s3_tfstate_file     = "database.tfstate"
aws_account_number  = 087942668956

##### DB Configuration #####
bcs_user           = "bcs_root"
bcs_instance_class = "db.t4g.medium"
bcs_maria_ids = {
  bcs-bcsadmin = {
    name = "bcs_bcsadmin_pw"
  },
  bcs-bcsapp = {
    name = "bcs_bcsapp_pw"
  }
}

centralwallet_user = "wallet_root"
centralwallet_mysql_ids = {
  centralwallet-walletadmin = {
    username = "centralwallet_walletadmin"
    name     = "centralwallet_walletadmin_pw"
  },
  centralwallet-walletapp = {
    username = "centralwallet_walletapp"
    name     = "centralwallet_walletapp_pw"
  },
  centralwallet-walletbatch = {
    username = "centralwallet_walletbatch"
    name     = "centralwallet_walletbatch_pw"
  }
}

mysql_clusters = {
  centralwallet-cluster = {
    name                  = "centralwallet",
    create_global_cluster = false,
    resource_prefix       = "",
    instance_class        = "db.t4g.medium",
    port                  = 3306,
    instance_count        = 2,
    master_username       = "wallet_root",
    apply_immediately     = true,
    skip_final_snapshot   = true,
    create_rds_proxy      = true,
    autoscaling_enabled   = false,
    tags = {
      BusinessOwnerPrimary        = "infra@bithumbmeta.io",
      SupportPlatformOwnerPrimary = "BithumMeta",
      OperationLevel              = "1"
    }
  }
}

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
  }
]
redis_password_spacial = true

##### memorydb-redis.tf #####
comm_redis_node_type = "db.t4g.small"
memorydb_user = {
  bc-centralwallet = {
    name = "bc-centralwallet"
  },
  kms = {
    name = "kms"
  }
}
