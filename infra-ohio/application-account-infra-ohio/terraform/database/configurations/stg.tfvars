##### Default Configuration #####
aws_region         = "us-east-2"
aws_shot_region    = "ue2"
environment        = "stg"
an2_env            = "stg"
service_name       = "naemo"
s3_tfstate_file    = "database.tfstate"
aws_account_number = 087942668956

##### DB Configuration #####
mysql_clusters = {
  marketplace-cluster = {
    name                  = "marketplace",
    create_global_cluster = false,
    resource_prefix       = "",
    instance_class        = "db.t4g.medium",
    port                  = 3306,
    instance_count        = 2,
    master_username       = "market_root",
    apply_immediately     = true,
    skip_final_snapshot   = true,
    create_rds_proxy      = true,
    autoscaling_enabled   = false,
    additionanl_sg_rules = {
      ingress-search = {
        source_security_group_id = "sg-058c58ea7ed9f50d5",
        description              = "3306 from searchengine"
      },
      seoul-appcidr = {
        cidr_blocks = ["10.0.33.128/27", "10.0.33.160/27"],
        description = "3306 from seoul app cidr"
      }
    },
    tags = {
      System                      = "marketplace",
      BusinessOwnerPrimary        = "infra@bithumbmeta.io",
      SupportPlatformOwnerPrimary = "BithumMeta",
      OperationLevel              = "2"
    }
  },
  systemadmin-cluster = {
    name                  = "systemadmin",
    create_global_cluster = false,
    resource_prefix       = "",
    instance_class        = "db.t4g.medium",
    port                  = 3306,
    instance_count        = 2,
    master_username       = "system_root",
    apply_immediately     = true,
    skip_final_snapshot   = true,
    create_rds_proxy      = true,
    autoscaling_enabled   = false,
    tags = {
      System                      = "systemadmin",
      BusinessOwnerPrimary        = "infra@bithumbmeta.io",
      SupportPlatformOwnerPrimary = "BithumMeta",
      OperationLevel              = "2"
    }
  },
  launchpad-cluster = {
    name                  = "launchpad",
    create_global_cluster = false,
    resource_prefix       = "",
    instance_class        = "db.t4g.medium",
    port                  = 3306,
    instance_count        = 2,
    master_username       = "launch_root",
    apply_immediately     = true,
    skip_final_snapshot   = true,
    create_rds_proxy      = true,
    autoscaling_enabled   = false,
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
  instance_class        = "db.t4g.medium",
  port                  = 3306,
  instance_count        = 1,
  master_username       = "web3mid_root",
  apply_immediately     = true,
  skip_final_snapshot   = true,
  create_rds_proxy      = true,
  autoscaling_enabled   = false,
  tags = {
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

marketplace_mysql_ids = {
  marketplace-marketadmin = {
    name = "market_marketadmin_pw"
  },
  marketplace-marketapp = {
    username = "market_marketapp"
    name     = "market_marketapp_pw"
  },
  marketplace-marketbatch = {
    username = "market_marketbatch"
    name     = "market_marketbatch_pw"
  },
  marketplace-systemapp = {
    username = "market_systemapp"
    name     = "market_systemapp_pw"
  },
  marketplace-launchapp = {
    username = "market_launchapp"
    name     = "market_launchapp_pw"
  },
  marketplace-metaverseadmin = {
    name = "market_metaadmin_pw"
  },
  marketplace-metaverseapp = {
    username = "market_metaapp"
    name     = "market_metaapp_pw"
  },
  marketplace-metaversebatch = {
    username = "market_metabatch"
    name     = "market_metabatch_pw"
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
    username = "launch_launchapp"
    name     = "launch_launchapp_pw"
  },
  launchpad-launchbatch = {
    username = "launch_launchbatch"
    name     = "launch_launchbatch_pw"
  },
  launchpad-systemapp = {
    username = "launch_systemapp"
    name     = "launch_systemapp_pw"
  },
}

systemadmin_mysql_ids = {
  systemadmin-systemadmin = {
    name = "system_systemadmin_pw"
  },
  systemadmin-systemapp = {
    username = "system_systemapp",
    name     = "system_systemapp_pw"
  },
  systemadmin-systembatch = {
    username = "system_systembatch",
    name     = "system_systembatch_pw"
  },
  systemadmin-notiadmin = {
    name = "system_notiadmin_pw"
  },
  systemadmin-notiapp = {
    username = "system_notiapp",
    name     = "system_notiapp_pw"
  },
  systemadmin-notibatch = {
    username = "system_notibatch",
    name     = "system_notibatch_pw"
  }
}

web3_middleware_ids = {
  eth-middleware-admin = {
    username = "eth_midadmin",
    name     = "eth_midadmin_pw"
  },
  eth-middleware-app = {
    username = "eth_midapp",
    name     = "eth_midapp_pw"
  },
  eth-middleware-batch = {
    username = "eth_midbatch",
    name     = "eth_midbatch_pw"
  },
  sol-middleware-admin = {
    username = "sol_midadmin",
    name     = "sol_midadmin_pw"
  },
  sol-middleware-app = {
    username = "sol_midapp",
    name     = "sol_midapp_pw"
  },
  sol-middleware-batch = {
    username = "sol_midbatch",
    name     = "sol_midbatch_pw"
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
