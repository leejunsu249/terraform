### VPC 참조 ###
data "aws_vpc" "redis_vpc" {
  id = var.vpc_id
}

data "aws_security_group" "manage-sg" {
  id = var.manage_sg
}

data "aws_elasticache_subnet_group" "redis_subnet_group"{
  name = var.redis_subnet_group
}


###
resource "aws_elasticache_replication_group" "api_service" {
  replication_group_id          = var.environment == "nprd" ? "${var.environment}-${var.service_name}-redis-api-service" : "${var.service_name}-redis-api-caching-service"
  description = "api-service replication group"

  engine         = "redis"
  engine_version = "6.x"
  node_type      = var.session_redis_node_type
  port           = 6379

  multi_az_enabled = var.redis_multi_az
  automatic_failover_enabled = var.redis_multi_az

  replicas_per_node_group = var.cluster_mode ? 1 : null #Replicas per Shard
  num_node_groups         = var.cluster_mode ? 1 : null #Replicas per Shar

  num_cache_clusters =  var.cluster_mode ? null : 1

  subnet_group_name = data.aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids = [aws_security_group.api_service.id, data.aws_security_group.manage-sg.id]

  kms_key_id = var.kms_redis_arn
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auth_token = module.secret_value_api_service_redis.secret_string

  parameter_group_name  = aws_elasticache_parameter_group.redis_api_service_param.name
  auto_minor_version_upgrade = false

  tags = {
    Name = "rd-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-api-caching-service",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
  depends_on = [
    aws_security_group.api_service
  ]
}

resource "aws_security_group" "api_service" {
  name        = "api-service-redis-sg"
  description = "Redis access"
  vpc_id      = data.aws_vpc.redis_vpc.id
  

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-api-caching-service",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "api_service" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = var.eks_cluster_node_sg_id
  description       = "6379 from eks"

  security_group_id = aws_security_group.api_service.id
}

resource "aws_security_group_rule" "access_wallet_app" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  cidr_blocks       = ["${element(var.wallet_app_cidr,0)}","${element(var.wallet_app_cidr,1)}"]
  description       = "6379 from wallet app eks"

  security_group_id = aws_security_group.api_service.id
}

resource "aws_ssm_parameter" "api_service_redis_endpoint" {
  name  = "pm-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-api-caching-service-endpoint"
  type  = "SecureString"
  value = jsonencode({
    "writer-endpoint": var.cluster_mode ? "${aws_elasticache_replication_group.api_service.configuration_endpoint_address}" : "${aws_elasticache_replication_group.api_service.primary_endpoint_address}",
    "reader-endpoint": "${aws_elasticache_replication_group.api_service.reader_endpoint_address}"
  })
}



# resource "aws_elasticache_subnet_group" "redis_subnet_group" {
#   name       = "rsg-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-api-caching-service"
#   subnet_ids = var.subnet_id
# }

resource "aws_elasticache_parameter_group" "redis_api_service_param" {
  name   = "rcp-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-api-caching-service"
  family = "redis6.x"

  dynamic "parameter" {
    for_each = var.cluster_mode ? concat([{ name = "cluster-enabled", value = "yes" }], var.parameter) : var.parameter

    content {
      name  = parameter.value.name
      value = tostring(parameter.value.value)
    }
  }
}

module "secret_value_api_service_redis" {
  source = "./modules/secret-value"
  name = "sm-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-api-caching-service-password"
  username = ""
  special = var.redis_password_spacial
}
