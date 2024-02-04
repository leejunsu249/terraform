resource "aws_elasticache_replication_group" "session_service_primary" {
  replication_group_id          = var.environment == "nprd" ? "${var.environment}-${var.service_name}-rd-primary-session-service" : "${var.service_name}-redis-primary-session-service"
  description = "session-service replication group"

  engine         = "redis"
  engine_version = "6.x"
  node_type      = var.session_redis_node_type
  port           = 6379

  multi_az_enabled = var.redis_multi_az
  automatic_failover_enabled = var.redis_multi_az

  replicas_per_node_group = var.cluster_mode ? 1 : null #Replicas per Shard
  num_node_groups         = var.cluster_mode ? 1 : null #Replicas per Shar

  num_cache_clusters =  var.cluster_mode ? null : 1

  subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids = [aws_security_group.session_service_redis_sg.id, aws_security_group.management_redis_sg.id]

  kms_key_id = data.terraform_remote_state.comm.outputs.kms_redis_arn
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auth_token = module.secret_value_session_service_redis.secret_string

  parameter_group_name  = aws_elasticache_parameter_group.redis_session_service_param.name
  auto_minor_version_upgrade = false

  tags = {
    Name = "rd-${var.aws_shot_region}-${var.environment}-${var.service_name}-primary-session-service",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group" "session_service_redis_sg" {
  name        = "session-service-redis-sg"
  description = "Redis access"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-session-service",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_eks_inbound_session_redis" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = data.terraform_remote_state.eks.outputs.cluster_node_sg_id
  description       = "6379 from eks"

  security_group_id = aws_security_group.session_service_redis_sg.id
}

resource "aws_ssm_parameter" "session_service_redis_endpoint" {
  name  = "pm-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-session-service-endpoint"
  type  = "SecureString"
  value = jsonencode({
    "writer-endpoint": var.cluster_mode ? "${aws_elasticache_replication_group.session_service_primary.configuration_endpoint_address}" : "${aws_elasticache_replication_group.session_service_primary.primary_endpoint_address}",
    "reader-endpoint": "${aws_elasticache_replication_group.session_service_primary.reader_endpoint_address}"
  })
}

resource "aws_elasticache_replication_group" "realtime_service_primary" {
  replication_group_id          = var.environment == "nprd" ? "${var.environment}-${var.service_name}-rd-primary-realtime-service" : "${var.service_name}-redis-primary-realtime-service"
  description = "realtime-service replication group"

  engine         = "redis"
  engine_version = "6.x"
  node_type      = var.session_redis_node_type
  port           = 6379

  multi_az_enabled = var.redis_multi_az
  automatic_failover_enabled = var.redis_multi_az

  replicas_per_node_group = var.cluster_mode ? 1 : null #Replicas per Shard
  num_node_groups         = var.cluster_mode ? 1 : null #Replicas per Shar

  num_cache_clusters =  var.cluster_mode ? null : 1

  subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids = [aws_security_group.realitme_service_redis_sg.id]

  kms_key_id = data.terraform_remote_state.comm.outputs.kms_redis_arn
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auth_token = module.secret_value_realtime_service_redis.secret_string

  parameter_group_name  = aws_elasticache_parameter_group.redis_realtime_service_param.name
  auto_minor_version_upgrade = false

  tags = {
    Name = "rd-${var.aws_shot_region}-${var.environment}-${var.service_name}-primary-realtime-service",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group" "realitme_service_redis_sg" {
  name        = "realitme-service-redis-sg"
  description = "Redis access"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-realitme-service",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_eks_inbound_realtime_redis" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = data.terraform_remote_state.eks.outputs.cluster_node_sg_id
  description       = "6379 from eks"

  security_group_id = aws_security_group.realitme_service_redis_sg.id
}

resource "aws_ssm_parameter" "realitme_service_redis_endpoint" {
  name  = "pm-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-realtime-service-endpoint"
  type  = "SecureString"
  value = jsonencode({
    "writer-endpoint": var.cluster_mode ? "${aws_elasticache_replication_group.realtime_service_primary.configuration_endpoint_address}" : "${aws_elasticache_replication_group.realtime_service_primary.primary_endpoint_address}",
    "reader-endpoint": "${aws_elasticache_replication_group.realtime_service_primary.reader_endpoint_address}"
  })
}

# ##### Redis Secret #####
module "secret_value_session_service_redis" {
  source = "../../modules/secret-value"
  name = "sm-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-session-service-password"
  username = ""
  special = var.redis_password_spacial
}

module "secret_value_realtime_service_redis" {
  source = "../../modules/secret-value"
  name = "sm-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-realtime-service-password"
  username = ""
  special = var.redis_password_spacial
}

resource "aws_elasticache_parameter_group" "redis_session_service_param" {
  name   = "rcp-${var.aws_shot_region}-${var.environment}-${var.service_name}-session-service"
  family = "redis6.x"

  dynamic "parameter" {
    for_each = var.cluster_mode ? concat([{ name = "cluster-enabled", value = "yes" }], var.parameter) : var.parameter

    content {
      name  = parameter.value.name
      value = tostring(parameter.value.value)
    }
  }
}

resource "aws_elasticache_parameter_group" "redis_realtime_service_param" {
  name   = "rcp-${var.aws_shot_region}-${var.environment}-${var.service_name}-realtime-service"
  family = "redis6.x"

  dynamic "parameter" {
    for_each = var.cluster_mode ? concat([{ name = "cluster-enabled", value = "yes" }], var.parameter) : var.parameter

    content {
      name  = parameter.value.name
      value = tostring(parameter.value.value)
    }
  }
}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "rsg-${var.aws_shot_region}-${var.environment}-${var.service_name}"
  subnet_ids = data.terraform_remote_state.network.outputs.db_subnets
}