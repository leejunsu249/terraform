module "web3_middleware_cluster" {
  source = "../../modules/aurora-global-cluster-msyql"

  resource_prefix           = var.web3_middleware_cluster.resource_prefix
  global_cluster_identifier = null
  create_global_cluster     = var.web3_middleware_cluster.create_global_cluster

  engine = "aurora-mysql"

  engine_version                  = "8.0.mysql_aurora.3.01.0"
  name                            = "rds-${var.aws_shot_region}-${var.environment}-${var.service_name}-${var.web3_middleware_cluster.name}"
  service_name                    = var.service_name
  service_name_lv2                = var.web3_middleware_cluster.name
  instance_class                  = var.web3_middleware_cluster.instance_class
  port                            = var.web3_middleware_cluster.port
  instance_count                  = var.web3_middleware_cluster.instance_count
  kms_key_id                      = data.terraform_remote_state.comm.outputs.kms_rds_arn
  master_username                 = var.web3_middleware_cluster.master_username
  vpc_id                          = data.terraform_remote_state.network.outputs.vpc_id
  db_subnet_group_name            = aws_db_subnet_group.web3_middleware_rds_aurora_subnet_group.id
  apply_immediately               = var.web3_middleware_cluster.apply_immediately
  skip_final_snapshot             = var.web3_middleware_cluster.skip_final_snapshot
  db_parameter_group_name         = aws_db_parameter_group.web3_middleware_aurora_parameter.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.web3_middleware_aurora_cluster_parameter.name
  additional_sg                   = [aws_security_group.management_rds_sg.id]

  secet_manager_name = "sm-${var.aws_shot_region}-${var.environment}-${var.service_name}-${var.web3_middleware_cluster.master_username}_pw"

  aws_shot_region = var.aws_shot_region
  environment     = var.environment

  cluster_node_sg_id = data.terraform_remote_state.eks.outputs.cluster_node_sg_id
  batch_cidr_blocks  = data.terraform_remote_state.network.outputs.batch_cidr_blocks

  create_rds_proxy = var.web3_middleware_cluster.create_rds_proxy
  db_subnets       = data.terraform_remote_state.network.outputs.db_subnets
  db_users         = local.db_users["web3_middleware"]

  tags = var.web3_middleware_cluster.tags
}

resource "aws_db_subnet_group" "web3_middleware_rds_aurora_subnet_group" {
  name       = "dsg-${var.aws_shot_region}-${var.environment}-${var.service_name}-${var.web3_middleware_cluster.name}"
  subnet_ids = data.terraform_remote_state.network.outputs.db_subnets

  tags = {
    Name                        = "dsg-${var.aws_shot_region}-${var.environment}-${var.service_name}-${var.web3_middleware_cluster.name}",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

##### Parameter Group #####
resource "aws_rds_cluster_parameter_group" "web3_middleware_aurora_cluster_parameter" {
  name        = "rcp-${var.aws_shot_region}-${var.environment}-${var.service_name}-${var.web3_middleware_cluster.name}"
  family      = "aurora-mysql8.0"
  description = "RDS cluster parameter group"

  parameter {
    name  = "autocommit"
    value = "1"
  }
  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_filesystem"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
  parameter {
    name  = "collation_connection"
    value = "utf8mb4_bin"
  }
  parameter {
    name  = "collation_server"
    value = "utf8mb4_bin"
  }
  dynamic "parameter" {
    for_each = (var.environment == "dev" || var.environment == "stg") ? ["max_connections"]:[]
  
    content {
      name  = "max_connections"
      value = "1000"
    }
  }
  parameter {
    name         = "lower_case_table_names"
    value        = "1"
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "general_log"
    value = 1
  }
  parameter {
    name  = "sql_mode"
    value = "PIPES_AS_CONCAT,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
  }
  parameter {
    name  = "transaction_isolation"
    value = "READ-COMMITTED"
  }
  parameter {
    name  = "long_query_time"
    value = "1"
  }
  parameter {
    name  = "slow_query_log"
    value = "1"
  }
  parameter {
    name  = "max_allowed_packet"
    value = "134217728"
  }
  parameter {
    name  = "log_bin_trust_function_creators"
    value = "1"
  }
  parameter {
    name  = "connect_timeout"
    value = "60"
  }
  parameter {
    name  = "max_connect_errors"
    value = "100000"
  }
  parameter {
    name  = "max_prepared_stmt_count"
    value = "1048576"
  }
  parameter {
    name  = "group_concat_max_len"
    value = "1048576"
  }
  parameter {
    name  = "log_output"
    value = "FILE"
  }
  parameter {
    name         = "innodb_sort_buffer_size"
    value        = (var.environment == "prd" || var.environment == "nprd") ? 8388608 : 1048576
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "join_buffer_size"
    value = (var.environment == "prd" || var.environment == "nprd") ? 2097152 : 262144
  }
  parameter {
    name  = "sort_buffer_size"
    value = (var.environment == "prd" || var.environment == "nprd") ? 2097152 : 262144
  }
  parameter {
    name  = "tmp_table_size"
    value = (var.environment == "prd" || var.environment == "nprd") ? 1073741824 : 16777216
  }
  parameter {
    name  = "max_heap_table_size"
    value = (var.environment == "prd" || var.environment == "nprd") ? 1073741824 : 16777216
  }
  parameter {
    name  = "innodb_lock_wait_timeout"
    value = 600
  }
  tags = {
    Name                        = "rcp-${var.aws_shot_region}-${var.environment}-${var.service_name}-${var.web3_middleware_cluster.name}",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_db_parameter_group" "web3_middleware_aurora_parameter" {
  name   = "rdp-${var.aws_shot_region}-${var.environment}-${var.service_name}-${var.web3_middleware_cluster.name}"
  family = "aurora-mysql8.0"

  parameter {
    name  = "autocommit"
    value = "1"
  }
  parameter {
    name         = "performance_schema"
    value        = (var.environment == "prd" || var.environment == "nprd") ? 1 : 0
    apply_method = "pending-reboot"
  }
  dynamic "parameter" {
    for_each = (var.environment == "dev" || var.environment == "stg") ? ["max_connections"]:[]
  
    content {
      name  = "max_connections"
      value = "1000"
    }
  }
  parameter {
    name  = "slow_query_log"
    value = "1"
  }
  parameter {
    name  = "sql_mode"
    value = "PIPES_AS_CONCAT,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
  }
  parameter {
    name  = "transaction_isolation"
    value = "READ-COMMITTED"
  }
  parameter {
    name  = "max_allowed_packet"
    value = "134217728"
  }
  parameter {
    name  = "log_bin_trust_function_creators"
    value = "1"
  }
  parameter {
    name  = "group_concat_max_len"
    value = "1048576"
  }
  parameter {
    name  = "log_output"
    value = "FILE"
  }
  parameter {
    name         = "innodb_sort_buffer_size"
    value        = (var.environment == "prd" || var.environment == "nprd") ? 8388608 : 1048576
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "join_buffer_size"
    value = (var.environment == "prd" || var.environment == "nprd") ? 2097152 : 262144
  }
  parameter {
    name         = "read_buffer_size"
    apply_method = "pending-reboot"
    value        = (var.environment == "prd" || var.environment == "nprd") ? 2097152 : 262144
  }
  parameter {
    name  = "sort_buffer_size"
    value = (var.environment == "prd" || var.environment == "nprd") ? 2097152 : 262144
  }
  parameter {
    name         = "read_rnd_buffer_size"
    apply_method = "pending-reboot"
    value        = (var.environment == "prd" || var.environment == "nprd") ? 2097152 : 524288
  }
  parameter {
    name  = "tmp_table_size"
    value = (var.environment == "prd" || var.environment == "nprd") ? 1073741824 : 16777216
  }
  parameter {
    name  = "max_heap_table_size"
    value = (var.environment == "prd" || var.environment == "nprd") ? 1073741824 : 16777216
  }
  parameter {
    name  = "innodb_lock_wait_timeout"
    value = 600
  }

  tags = {
    Name                        = "rdp-${var.aws_shot_region}-${var.environment}-${var.service_name}-${var.web3_middleware_cluster.name}",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

##### User Account #####
module "web3_middleware_secret_value" {
  for_each = var.web3_middleware_ids

  source   = "../../modules/secret-value"
  name     = "sm-${var.aws_shot_region}-${var.environment}-${var.service_name}-${each.value.name}"
  smname   = "${try(each.value.username, "")}" != "" ? "sm-${var.aws_shot_region}-${var.environment}-${var.service_name}-${each.value.username}" : ""
  username = try(each.value.username, "")
}
