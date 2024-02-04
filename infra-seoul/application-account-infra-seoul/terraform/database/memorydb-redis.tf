resource "aws_memorydb_cluster" "comm_service" {
  acl_name                   = aws_memorydb_acl.comm_service.name
  name                       = "redis-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-comm-service"
  engine_version             = "6.2"
  description                = "comm-service memorydb redis cluster"
  node_type                  = var.comm_redis_node_type
  num_shards                 = 1
  num_replicas_per_shard     = var.environment == "dev" ? 0 : 1
  #num_replicas_per_shard     = contains(["dev","stg"], var.environment) ? 0 : 1
  port                       = 6379
  security_group_ids         = [aws_security_group.wallet_management_redis_sg.id, aws_security_group.wallet_comm_service_redis_sg.id]
  snapshot_retention_limit   = 7
  subnet_group_name          = aws_memorydb_subnet_group.wallet_redis_subnet_group.id
  auto_minor_version_upgrade = false
  maintenance_window         = "sun:23:00-mon:01:30"
  kms_key_arn                = data.terraform_remote_state.comm.outputs.kms_redis_arn
  tls_enabled                = true

  tags = {
    Name = "redis-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-comm-service",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group" "wallet_comm_service_redis_sg" {
  name        = "wallet-comm-service-redis-sg"
  description = "Redis access"
  vpc_id      = data.terraform_remote_state.network.outputs.wallet_vpc_id

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-redis-comm-service",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_security_group_rule" "allow_inbound_eks_comm_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = data.terraform_remote_state.eks.outputs.cluster_node_sg_id
  description              = "6379 from eks"

  security_group_id = aws_security_group.wallet_comm_service_redis_sg.id
}

resource "aws_security_group_rule" "allow_inbound_kms_comm_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = data.terraform_remote_state.comm.outputs.wallet_kms_sg_id
  description              = "6379 from kms"

  security_group_id = aws_security_group.wallet_comm_service_redis_sg.id
}

resource "aws_ssm_parameter" "comm_service_redis_endpoint" {
  name = "pm-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-redis-comm-service-endpoint"
  type = "SecureString"
  value = jsonencode({
    "cluster-endpoint" : "${aws_memorydb_cluster.comm_service.cluster_endpoint[0]["address"]}"
  })
}

resource "aws_memorydb_acl" "comm_service" {
  name       = "rdacl-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-comm-service"
  user_names = [for i in aws_memorydb_user.comm_service : i.id]
  tags = {
    Name = "rdacl-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-comm-service",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_memorydb_user" "comm_service" {
  for_each      = var.memorydb_user
  user_name     = each.value.name
  access_string = "on ~* &* +@all"

  authentication_mode {
    type      = "password"
    passwords = [for i in module.secret_value_comm_service_redis : i.secret_string]
  }
  tags = {
    Name = "redis-user-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-${each.value.name}",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

# ##### Redis Secret #####
module "secret_value_comm_service_redis" {
  source   = "../../modules/secret-value"
  for_each = var.memorydb_user
  name     = "sm-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-redis-comm-service-${each.value.name}-password"
  username = ""
  special  = var.redis_password_spacial
}

resource "aws_memorydb_subnet_group" "wallet_redis_subnet_group" {
  name       = "rsg-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}-md"
  subnet_ids = data.terraform_remote_state.network.outputs.wallet_db_subnets
}
