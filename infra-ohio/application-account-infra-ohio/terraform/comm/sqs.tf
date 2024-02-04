resource "aws_sqs_queue" "notification_default_queue" {
  name                      = "sqs-${var.aws_shot_region}-${var.environment}-default-notification-email"
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 0

  sqs_managed_sse_enabled = true

  tags = {
    Name = "sqs-${var.aws_shot_region}-${var.environment}-default-notification-email",
    System                      = "notification",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_sqs_queue" "notification_default_local_queue" {
  count = var.environment == "dev" ? 1:0

  name                      = "sqs-${var.aws_shot_region}-${var.environment}-default-notification-email-local"
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 0

  sqs_managed_sse_enabled = true

  tags = {
    Name = "sqs-${var.aws_shot_region}-${var.environment}-default-notification-email-local",
    System                      = "notification",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_sqs_queue" "fifo_marketpalce_voucher" {
  name                      = "sqs-${var.aws_shot_region}-${var.environment}-fifo-marketplace-voucher.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  deduplication_scope   = "messageGroup"
  fifo_throughput_limit = "perMessageGroupId"
  sqs_managed_sse_enabled = true

  tags = {
    Name = "sqs-${var.aws_shot_region}-${var.environment}-fifo-marketplace-voucher.fifo",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }  
}

resource "aws_sqs_queue" "fifo_marketpalce_voucher_feature_queue" {
  count = var.environment == "dev" ? 1:0

  name                      = "sqs-${var.aws_shot_region}-${var.environment}-fifo-marketplace-voucher-feature.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  deduplication_scope   = "messageGroup"
  fifo_throughput_limit = "perMessageGroupId"
  sqs_managed_sse_enabled = true

  tags = {
    Name = "sqs-${var.aws_shot_region}-${var.environment}-fifo-marketplace-voucher.fifo",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }  
}

resource "aws_sqs_queue" "metaverse_inf_queue" {
  name                      = "sqs-${var.aws_shot_region}-${var.environment}-metaverse-inf"
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 0

  sqs_managed_sse_enabled = true

  tags = {
    Name = "sqs-${var.aws_shot_region}-${var.environment}-metaverse-inf",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }  
}


resource "aws_sqs_queue" "nft-transfer-airdrop_default_queue" {
  count = var.environment == "dev" ? 1:0
  name                      = "sqs-${var.aws_shot_region}-${var.environment}-default-nft-transfer-airdrop"
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 345600
  receive_wait_time_seconds = 0

  sqs_managed_sse_enabled = true

  tags = {
    Name = "sqs-${var.aws_shot_region}-${var.environment}-default-nft-transfer-airdrop",
    System                      = "nft-transfer-airdrop",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_sqs_queue" "ethereum_edition_queue" {
  name                      = "sqs-${var.aws_shot_region}-${var.environment}-default-ethereum-edition"
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 345600
  receive_wait_time_seconds = 0

  sqs_managed_sse_enabled = true

  tags = {
    Name = "sqs-${var.aws_shot_region}-${var.environment}-default-ethereum-edition",
    System                      = "ethereum-edition",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_sqs_queue" "solana-edition-queue" {
  name                      = "sqs-${var.aws_shot_region}-${var.environment}-default-solana-edition"
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 345600
  receive_wait_time_seconds = 0

  sqs_managed_sse_enabled = true

  tags = {
    Name = "sqs-${var.aws_shot_region}-${var.environment}-default-solana-edition",
    System                      = "solana-edition",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_sqs_queue" "polygon-edition-queue" {
  name                      = "sqs-${var.aws_shot_region}-${var.environment}-default-polygon-edition"
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 345600
  receive_wait_time_seconds = 0

  sqs_managed_sse_enabled = true

  tags = {
    Name = "sqs-${var.aws_shot_region}-${var.environment}-default-polygon-edition",
    System                      = "polygon-edition",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}