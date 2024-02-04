# resource "aws_db_instance" "mona_mgr" {
#   allocated_storage    = 20
#   engine               = "mariadb"
#   engine_version       = "10.6.7"
#   instance_class       = "db.t3.medium"
#   name                 = "monamgr"
#   username             = "mona"
#   password             = aws_secretsmanager_secret_version.secret_value_credentials.secret_string
#   identifier           = "rds-ue2-dev-mona"
#   port                 = "13306"
#   storage_encrypted = true
#   kms_key_id = data.aws_kms_key.rds.arn
#   # parameter_group_name = "default.mariadb10.6"
#   parameter_group_name = aws_db_parameter_group.mona_db_parameter.name
#   db_subnet_group_name = aws_db_subnet_group.mona_mgr_subnet_group.name
#   skip_final_snapshot  = true
#   vpc_security_group_ids    = [aws_security_group.monachain_rds_sg.id]
# }

# resource "aws_security_group" "monachain_rds_sg" {
#   name = "rds-monachain-sg"
#   description = "Mona rds Sg for access"
#   vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

#   tags = {
#     Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-monachain-rds"
#   }
# }

# resource "aws_security_group_rule" "allow_monamgr_rds_inbound" {
#     description              = "sql from vpc" 
#     from_port                = 13306 
#     protocol                 = "tcp" 
#     to_port                  = 13306
#     type                     = "ingress" 
#     security_group_id        = aws_security_group.monachain_rds_sg.id
#     source_security_group_id = aws_security_group.monachain_monamgr_sg.id
#     depends_on = [
#         aws_security_group.monachain_monamgr_sg,
#     ]
# }

# resource "aws_security_group_rule" "allow_monamgr_rds_inbound_from_bastion" {
#     description              = "inbound from bastion" 
#     from_port                = 13306
#     protocol                 = "tcp" 
#     to_port                  = 13306
#     type                     = "ingress" 
#     security_group_id        = aws_security_group.monachain_rds_sg.id
#     cidr_blocks              = ["10.0.1.138/32"]
# }

# resource "aws_security_group_rule" "allow_rds_outbound" {
#     cidr_blocks              = ["0.0.0.0/0"]
#     description              = "all from vpc" 
#     from_port                = 0 
#     protocol                 = "tcp" 
#     to_port                  = 65535    
#     type                     = "egress" 
#     security_group_id        = aws_security_group.monachain_rds_sg.id
# }

# resource "aws_db_subnet_group" "mona_mgr_subnet_group" {
#   name       = "dsg-rds-mona-mgr"
#   subnet_ids = [data.terraform_remote_state.network.outputs.db_subnets[0], data.terraform_remote_state.network.outputs.db_subnets[1]]

#   tags = {
#     Name = "dsg-${var.aws_shot_region}-${var.environment}-${var.service_name}-monamgr"
#   }
# }

# ##### Parameter Group #####
# resource "aws_db_parameter_group" "mona_db_parameter" {
#   name        = "rds-params-mona-mgr"
#   family      = "mariadb10.6"
#   description = "RDS parameter group"

#   parameter {
#     name  = "autocommit"
#     value = "1"
#   }
#   parameter {
#     name  = "character_set_client"
#     value = "utf8mb4"
#   }
#   parameter {
#     name  = "character_set_connection"
#     value = "utf8mb4"
#   }
#   parameter {
#     name  = "character_set_database"
#     value = "utf8mb4"
#   }
#   parameter {
#     name  = "character_set_filesystem"
#     value = "utf8mb4"
#   }
#   parameter {
#     name  = "character_set_results"
#     value = "utf8mb4"
#   }
#   parameter {
#     name  = "character_set_server"
#     value = "utf8"
#   }
#   parameter {
#     name  = "collation_connection"
#     value = "utf8mb4_bin"
#   }
#   parameter {
#     name  = "collation_server"
#     value = "utf8_general_ci"
#   }
#   parameter {
#     name         = "lower_case_table_names"
#     value        = "1"
#     apply_method = "pending-reboot"
#   }
#   parameter {
#     name  = "max_connections"
#     value = 1000
#   }
#   parameter {
#     name  = "sql_mode"
#     value = "PIPES_AS_CONCAT,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
#   }
#   # parameter {
#   #   name  = "transaction_isolation"
#   #   value = "READ-COMMITTED"
#   # }
#   parameter {
#     name  = "connect_timeout" 
#     value = "60"
#   }
#   parameter {
#     name  = "max_connect_errors"
#     value = "100000"
#   }
#   parameter {
#     name  = "max_prepared_stmt_count"
#     value = "1048576"
#   }
#   parameter {
#     name  = "long_query_time"
#     value = 5
#   }
#   parameter {
#     name  = "log_bin_trust_function_creators"
#     value = "1"
#   }

#   tags = {
#     Name = "dpg-${var.aws_shot_region}-${var.environment}-${var.service_name}-monamgr"
#   }
# }