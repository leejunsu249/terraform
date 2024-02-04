resource "aws_db_instance" "bcs" {
  allocated_storage   = 20
  engine              = "mariadb"
  engine_version      = "10.6.8"
  instance_class      = var.bcs_instance_class
  db_name             = "bcsmgr"
  username            = var.bcs_user
  password            = aws_secretsmanager_secret_version.maria_credentials.secret_string
  identifier          = "rds-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs"
  port                = "13306"
  storage_encrypted   = true
  kms_key_id          = data.terraform_remote_state.comm.outputs.kms_rds_arn
  deletion_protection = true
  # parameter_group_name = "default.mariadb10.6"
  parameter_group_name       = aws_db_parameter_group.rds_db_parameter.name
  db_subnet_group_name       = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot        = true
  vpc_security_group_ids     = [aws_security_group.management_rds_sg.id, aws_security_group.bcs_rds_sg.id]
  backup_retention_period    = 7
  auto_minor_version_upgrade = false
  backup_window              = "02:00-03:00"
  apply_immediately          = true
  tags = {
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "dsg-${var.aws_shot_region}-${var.environment}-${var.service_name}"
  subnet_ids = data.terraform_remote_state.network.outputs.db_subnets

  tags = {
    Name                        = "dsg-${var.aws_shot_region}-${var.environment}-${var.service_name}",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

##### Parameter Group #####
resource "aws_db_parameter_group" "rds_db_parameter" {
  name        = "dpg-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs"
  family      = "mariadb10.6"
  description = "RDS parameter group"

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
    value = "utf8"
  }
  parameter {
    name  = "collation_connection"
    value = "utf8mb4_bin"
  }
  parameter {
    name  = "collation_server"
    value = "utf8_general_ci"
  }
  parameter {
    name         = "lower_case_table_names"
    value        = "1"
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "max_connections"
    value = 1000
  }
  parameter {
    name  = "sql_mode"
    value = "PIPES_AS_CONCAT,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
  }
  # parameter {
  #   name  = "transaction_isolation"
  #   value = "READ-COMMITTED"
  # }
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
    name  = "long_query_time"
    value = 5
  }
  parameter {
    name  = "log_bin_trust_function_creators"
    value = "1"
  }

  tags = {
    Name                        = "dpg-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

##### Root Password #####
resource "random_password" "maria_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "maria_credentials" {
  name = "sm-${var.aws_shot_region}-${var.environment}-${var.service_name}-${var.bcs_user}"
}

resource "aws_secretsmanager_secret_version" "maria_credentials" {
  secret_id     = aws_secretsmanager_secret.maria_credentials.id
  secret_string = random_password.maria_password.result
}

##### User Account #####
module "secret_value_system" {
  for_each = var.bcs_maria_ids

  source = "../../modules/secret-value"
  name   = "sm-${var.aws_shot_region}-${var.environment}-${var.service_name}-${each.value.name}"
}
