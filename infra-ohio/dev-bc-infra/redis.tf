### VPC 참조 ###
data "aws_vpc" "redis_vpc" {
  id = var.vpc_id
}

###
resource "aws_elasticache_replication_group" "session_service_primary-bc" {
  replication_group_id          = var.environment == "nprd" ? "${var.environment}-${var.service_name}-rd-primary-session-service" : "${var.service_name}-redis-primary-session-service-bc"
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
  security_group_ids = [aws_security_group.session_service_redis_sg-bc.id, aws_security_group.management_redis_sg-bc.id]

  kms_key_id = var.kms_redis_arn
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auth_token = module.secret_value_session_service_redis.secret_string

  parameter_group_name  = aws_elasticache_parameter_group.redis_session_service_param.name
  auto_minor_version_upgrade = false

  tags = {
    Name = "rd-${var.aws_shot_region}-${var.environment}-${var.service_name}-primary-session-service-bc",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
  depends_on = [
    aws_security_group.session_service_redis_sg-bc,
    aws_security_group.management_redis_sg-bc
  ]
}

resource "aws_security_group" "session_service_redis_sg-bc" {
  name        = "session-service-redis-sg-bc"
  description = "Redis access"
  vpc_id      = data.aws_vpc.redis_vpc.id
  

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-session-service-bc",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_eks_inbound_session_redis-bc" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = var.eks_cluster_node_sg_id
  description       = "6379 from eks"

  security_group_id = aws_security_group.session_service_redis_sg-bc.id
}

resource "aws_ssm_parameter" "session_service_redis_endpoint" {
  name  = "pm-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-session-service-endpoint-bc"
  type  = "SecureString"
  value = jsonencode({
    "writer-endpoint": var.cluster_mode ? "${aws_elasticache_replication_group.session_service_primary-bc.configuration_endpoint_address}" : "${aws_elasticache_replication_group.session_service_primary-bc.primary_endpoint_address}",
    "reader-endpoint": "${aws_elasticache_replication_group.session_service_primary-bc.reader_endpoint_address}"
  })
}

resource "aws_elasticache_replication_group" "realtime_service_primary" {
  replication_group_id          = var.environment == "nprd" ? "${var.environment}-${var.service_name}-rd-primary-realtime-service" : "${var.service_name}-redis-primary-realtime-service-bc"
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
  security_group_ids = [aws_security_group.realitme_service_redis_sg-bc.id]

  kms_key_id = var.kms_redis_arn
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auth_token = module.secret_value_realtime_service_redis.secret_string

  parameter_group_name  = aws_elasticache_parameter_group.redis_realtime_service_param.name
  auto_minor_version_upgrade = false

  tags = {
    Name = "rd-${var.aws_shot_region}-${var.environment}-${var.service_name}-primary-realtime-service-bc",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group" "realitme_service_redis_sg-bc" {
  name        = "realitme-service-redis-sg-bc"
  description = "Redis access"
  vpc_id      = data.aws_vpc.redis_vpc.id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-realitme-service-bc",
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
  source_security_group_id = var.eks_cluster_node_sg_id
  description       = "6379 from eks"

  security_group_id = aws_security_group.realitme_service_redis_sg-bc.id
}

resource "aws_ssm_parameter" "realitme_service_redis_endpoint" {
  name  = "pm-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-realtime-service-endpoint-bc"
  type  = "SecureString"
  value = jsonencode({
    "writer-endpoint": var.cluster_mode ? "${aws_elasticache_replication_group.realtime_service_primary.configuration_endpoint_address}" : "${aws_elasticache_replication_group.realtime_service_primary.primary_endpoint_address}",
    "reader-endpoint": "${aws_elasticache_replication_group.realtime_service_primary.reader_endpoint_address}"
  })
}

resource "aws_elasticache_replication_group" "api_service" {
  replication_group_id          = var.environment == "nprd" ? "${var.environment}-${var.service_name}-redis-api-service" : "${var.service_name}-redis-api-caching-service-bc"
  description = "api-service replication group bc"

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
  security_group_ids = [aws_security_group.api_service.id, aws_security_group.management_redis_sg-bc.id]

  kms_key_id = var.kms_redis_arn
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auth_token = module.secret_value_api_service_redis.secret_string

  parameter_group_name  = aws_elasticache_parameter_group.redis_api_service_param.name
  auto_minor_version_upgrade = false

  tags = {
    Name = "rd-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-api-caching-service-bc",
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
  name        = "api-service-redis-sg-bc"
  description = "Redis access"
  vpc_id      = data.aws_vpc.redis_vpc.id
  

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-api-caching-service-bc",
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

resource "aws_ssm_parameter" "api_service_redis_endpoint" {
  name  = "pm-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-api-caching-service-endpoint-bc"
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
  name   = "rcp-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-api-caching-service-bc"
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
  name = "sm-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-api-caching-service-password-bc"
  username = ""
  special = var.redis_password_spacial
}


# ##### Redis Secret #####
module "secret_value_session_service_redis" {
  source = "./modules/secret-value"
  name = "sm-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-session-service-password-bc"
  username = ""
  special = var.redis_password_spacial
}

module "secret_value_realtime_service_redis" {
  source = "./modules/secret-value"
  name = "sm-${var.aws_shot_region}-${var.environment}-${var.service_name}-redis-realtime-service-password-bc"
  username = ""
  special = var.redis_password_spacial
}

resource "aws_elasticache_parameter_group" "redis_session_service_param" {
  name   = "rcp-${var.aws_shot_region}-${var.environment}-${var.service_name}-session-service-bc"
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
  name   = "rcp-${var.aws_shot_region}-${var.environment}-${var.service_name}-realtime-service-bc"
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
  name       = "rsg-${var.aws_shot_region}-${var.environment}-${var.service_name}-bc"
  subnet_ids = var.subnet_id
}



###wallet 망 ### 

### VPC 참조 ###
data "aws_vpc" "an2_redis_vpc" {
  id = var.an2_vpc_id
  provider = aws.an2
}


resource "aws_elasticache_replication_group" "session_service_primary" {
  replication_group_id = "rd-${var.wallet_service_name}-primary-session-svc-bc"
  description          = "wallet-session-service replication group bc"

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
  security_group_ids = [aws_security_group.management_redis_sg-bc-an2.id, aws_security_group.wallet_session_service_redis_sg.id]

  kms_key_id                 = var.an2_kms_redis_arn
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auth_token                 = module.secret_value_session_service_redis-an2.secret_string

  parameter_group_name       = aws_elasticache_parameter_group.redis_session_service_param-an2.name
  auto_minor_version_upgrade = false

  tags = {
    Name = "rd-${var.aws_an2_shot_region}-${var.environment}-${var.wallet_service_name}-primary-session-service-bc",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
  provider = aws.an2
}

resource "aws_security_group" "wallet_session_service_redis_sg" {
  name        = "wallet-session-service-redis-sg-bc"
  description = "Redis access"
  vpc_id      = data.aws_vpc.an2_redis_vpc.id

  tags = {
    Name = "sg-${var.aws_an2_shot_region}-${var.environment}-${var.wallet_service_name}-redis-session-service-bc",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
  provider = aws.an2
}

resource "aws_security_group_rule" "allow_eks_inbound_session_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = var.an2_eks_cluster_node_sg_id
  description              = "6379 from eks"

  security_group_id = aws_security_group.wallet_session_service_redis_sg.id
  provider = aws.an2
}

resource "aws_ssm_parameter" "session_service_redis_endpoint-an2" {
  name = "pm-${var.aws_an2_shot_region}-${var.environment}-${var.wallet_service_name}-redis-session-service-endpoint-bc"
  type = "SecureString"
  value = jsonencode({
    "writer-endpoint" : var.cluster_mode ? "${aws_elasticache_replication_group.session_service_primary.configuration_endpoint_address}" : "${aws_elasticache_replication_group.session_service_primary.primary_endpoint_address}",
    "reader-endpoint" : "${aws_elasticache_replication_group.session_service_primary.reader_endpoint_address}"
  })
  provider = aws.an2
}

resource "aws_security_group" "wallet_realitme_service_redis_sg" {
  name        = "wallet-realitme-service-redis-sg-bc"
  description = "Redis access"
  vpc_id      = data.aws_vpc.an2_redis_vpc.id

  tags = {
    Name = "sg-${var.aws_an2_shot_region}-${var.environment}-${var.wallet_service_name}-redis-realitme-service",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
  provider = aws.an2
}

# ##### Redis Secret #####
module "secret_value_session_service_redis-an2" {
  source   = "./modules/secret-value"
  name     = "sm-${var.aws_an2_shot_region}-${var.environment}-${var.wallet_service_name}-redis-session-service-password-bc"
  username = ""
  special  = var.redis_password_spacial
  providers = {
    aws = aws.an2
    }
}

resource "aws_elasticache_parameter_group" "redis_session_service_param-an2" {
  name   = "rcp-${var.aws_an2_shot_region}-${var.environment}-${var.wallet_service_name}-session-service-bc"
  family = "redis6.x"

  dynamic "parameter" {
    for_each = var.cluster_mode ? concat([{ name = "cluster-enabled", value = "yes" }], var.parameter) : var.parameter

    content {
      name  = parameter.value.name
      value = tostring(parameter.value.value)
    }
  }
  provider = aws.an2
}

resource "aws_elasticache_subnet_group" "wallet_redis_subnet_group" {
  name       = "rsg-${var.aws_an2_shot_region}-${var.environment}-${var.wallet_service_name}-ec-bc"
  subnet_ids = var.an2_subnet_id
  provider = aws.an2
}
