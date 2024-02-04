resource "aws_elasticache_replication_group" "session_service_primary" {
  replication_group_id = "rd-${var.wallet_service_name}-primary-session-service"
  description          = "wallet-session-service replication group"

  engine         = "redis"
  engine_version = "6.x"
  node_type      = var.session_redis_node_type
  port           = 6379

  multi_az_enabled           = var.redis_multi_az
  automatic_failover_enabled = var.redis_multi_az

  replicas_per_node_group = var.cluster_mode ? 1 : null #Replicas per Shard
  num_node_groups         = var.cluster_mode ? 1 : null #Replicas per Shar

  num_cache_clusters = var.cluster_mode ? null : 1

  subnet_group_name  = aws_elasticache_subnet_group.wallet_redis_subnet_group.name
  security_group_ids = [aws_security_group.wallet_management_redis_sg.id, aws_security_group.wallet_session_service_redis_sg.id]

  kms_key_id                 = data.terraform_remote_state.comm.outputs.kms_redis_arn
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auth_token                 = module.secret_value_session_service_redis.secret_string

  parameter_group_name       = aws_elasticache_parameter_group.redis_session_service_param.name
  auto_minor_version_upgrade = false

  tags = {
    Name = "rd-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-primary-session-service",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_security_group" "wallet_session_service_redis_sg" {
  name        = "wallet-session-service-redis-sg"
  description = "Redis access"
  vpc_id      = data.terraform_remote_state.network.outputs.wallet_vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-redis-session-service",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

resource "aws_security_group_rule" "allow_eks_inbound_session_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = data.terraform_remote_state.eks.outputs.cluster_node_sg_id
  description              = "6379 from eks"

  security_group_id = aws_security_group.wallet_session_service_redis_sg.id
}

resource "aws_ssm_parameter" "session_service_redis_endpoint" {
  name = "pm-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-redis-session-service-endpoint"
  type = "SecureString"
  value = jsonencode({
    "writer-endpoint" : var.cluster_mode ? "${aws_elasticache_replication_group.session_service_primary.configuration_endpoint_address}" : "${aws_elasticache_replication_group.session_service_primary.primary_endpoint_address}",
    "reader-endpoint" : "${aws_elasticache_replication_group.session_service_primary.reader_endpoint_address}"
  })
}

resource "aws_security_group" "wallet_realitme_service_redis_sg" {
  name        = "wallet-realitme-service-redis-sg"
  description = "Redis access"
  vpc_id      = data.terraform_remote_state.network.outputs.wallet_vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-redis-realitme-service",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
}

# ##### Redis Secret #####
module "secret_value_session_service_redis" {
  source   = "../../modules/secret-value"
  name     = "sm-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-redis-session-service-password"
  username = ""
  special  = var.redis_password_spacial
}

resource "aws_elasticache_parameter_group" "redis_session_service_param" {
  name   = "rcp-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-session-service"
  family = "redis6.x"

  dynamic "parameter" {
    for_each = var.cluster_mode ? concat([{ name = "cluster-enabled", value = "yes" }], var.parameter) : var.parameter

    content {
      name  = parameter.value.name
      value = tostring(parameter.value.value)
    }
  }
}

resource "aws_elasticache_subnet_group" "wallet_redis_subnet_group" {
  name       = "rsg-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-ec"
  subnet_ids = data.terraform_remote_state.network.outputs.wallet_db_subnets
}
