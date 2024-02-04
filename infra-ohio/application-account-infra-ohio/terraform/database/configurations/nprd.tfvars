##### Default Configuration #####
aws_region         = "us-east-2"
aws_shot_region    = "ue2"
environment        = "nprd"
an2_env            = "prd"
service_name       = "naemo"
s3_tfstate_file    = "database.tfstate"
aws_account_number = 908317417455

##### DB Configuration #####
mysql_clusters = {
  marketplace-cluster = {
    name                     = "marketplace",
    create_global_cluster    = false,
    resource_prefix          = "",
    instance_class           = "db.r6g.2xlarge",
    port                     = 3306,
    instance_count           = 2,
    master_username          = "market_root",
    apply_immediately        = true,
    skip_final_snapshot      = true,
    create_rds_proxy         = false,
    autoscaling_enabled      = true,
    autoscaling_min_capacity = 2,
    autoscaling_max_capacity = 5,
    predefined_metric_type   = "RDSReaderAverageCPUUtilization",
    autoscaling_target_cpu   = 70,
    tags = {
      System                      = "marketplace",
      BusinessOwnerPrimary        = "infra@bithumbmeta.io",
      SupportPlatformOwnerPrimary = "BithumMeta",
      OperationLevel              = "2"
    }
  },
  systemadmin-cluster = {
    name                     = "systemadmin",
    create_global_cluster    = false,
    resource_prefix          = "",
    instance_class           = "db.r6g.xlarge",
    port                     = 3306,
    instance_count           = 2,
    master_username          = "system_root",
    apply_immediately        = true,
    skip_final_snapshot      = true,
    create_rds_proxy         = false,
    autoscaling_enabled      = true,
    autoscaling_min_capacity = 1,
    autoscaling_max_capacity = 5,
    predefined_metric_type   = "RDSReaderAverageCPUUtilization",
    autoscaling_target_cpu   = 70,
    tags = {
      System                      = "systemadmin",
      BusinessOwnerPrimary        = "infra@bithumbmeta.io",
      SupportPlatformOwnerPrimary = "BithumMeta",
      OperationLevel              = "2"
    }
  },
  launchpad-cluster = {
    name                     = "launchpad",
    create_global_cluster    = false,
    resource_prefix          = "",
    instance_class           = "db.r6g.xlarge",
    port                     = 3306,
    instance_count           = 2,
    master_username          = "launch_root",
    apply_immediately        = true,
    skip_final_snapshot      = true,
    create_rds_proxy         = false,
    autoscaling_enabled      = true,
    autoscaling_min_capacity = 1,
    autoscaling_max_capacity = 5,
    predefined_metric_type   = "RDSReaderAverageCPUUtilization",
    autoscaling_target_cpu   = 70,
    tags = {
      System                      = "launchpad",
      BusinessOwnerPrimary        = "infra@bithumbmeta.io",
      SupportPlatformOwnerPrimary = "BithumMeta",
      OperationLevel              = "2"
    }
  }
}

web3_middleware_cluster = {
  name                  = "web3-middleware",
  create_global_cluster = false,
  resource_prefix       = "",
  instance_class        = "db.r6g.xlarge",
  port                  = 3306,
  instance_count        = 1,
  master_username       = "web3mid_root",
  apply_immediately     = true,
  skip_final_snapshot   = true,
  create_rds_proxy      = false,
  autoscaling_enabled   = false,
  tags = {
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

#max_connections = 2000

marketplace_mysql_ids = {
  marketplace-marketadmin = {
    name = "market_marketadmin_pw"
  },
  marketplace-marketapp = {
    username = "market_marketapp"
    name     = "market_marketapp_pw"
  },
  marketplace-marketbatch = {
    name = "market_marketbatch_pw"
  },
  marketplace-systemapp = {
    name = "market_systemapp_pw"
  },
  marketplace-launchapp = {
    name = "market_launchapp_pw"
  },
  marketplace-metaverseadmin = {
    name = "market_metaadmin_pw"
  },
  marketplace-metaverseapp = {
    name = "market_metaapp_pw"
  },
  marketplace-metaversebatch = {
    name = "market_metabatch_pw"
  },
  marketplace-searchapp = {
    name = "market_searchapp_pw"
  },  
  marketplace-walletapp = {
    name = "market_walletapp_pw"
  }
}

launchpad_mysql_ids = {
  launchpad-launchadmin = {
    name = "launch_launchadmin_pw"
  },
  launchpad-launchapp = {
    name = "launch_launchapp_pw"
  },
  launchpad-launchbatch = {
    name = "launch_launchbatch_pw"
  },
  launchpad-systemapp = {
    name = "launch_systemapp_pw"
  },
}

systemadmin_mysql_ids = {
  systemadmin-systemadmin = {
    name = "system_systemadmin_pw"
  },
  systemadmin-systemapp = {
    name = "system_systemapp_pw"
  },
  systemadmin-systembatch = {
    name = "system_systembatch_pw"
  },
  systemadmin-notiadmin = {
    name = "system_notiadmin_pw"
  },
  systemadmin-notiapp = {
    name = "system_notiapp_pw"
  },
  systemadmin-notibatch = {
    name = "system_notibatch_pw"
  }
}

web3_middleware_ids = {
  eth-middleware-admin = {
    name = "eth_midadmin_pw"
  },
  eth-middleware-app = {
    name = "eth_midapp_pw"
  },
  eth-middleware-batch = {
    name = "eth_midbatch_pw"
  },
  sol-middleware-admin = {
    name = "sol_midadmin_pw"
  },
  sol-middleware-app = {
    name = "sol_midapp_pw"
  },
  sol-middleware-batch = {
    name = "sol_midbatch_pw"
  }
}

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
