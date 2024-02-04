resource "aws_sqs_queue" "notification_default_queue_beta" {
  count = var.environment == "dev" ? 1:0

  name                      = "sqs-${var.aws_shot_region}-${var.environment}-default-notification-email-beta"
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 0

  sqs_managed_sse_enabled = true

  tags = {
    Name = "sqs-${var.aws_shot_region}-${var.environment}-default-notification-email-beta",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }  
}

resource "aws_sqs_queue" "notification_default_local_queue_beta" {
  count = var.environment == "dev" ? 1:0

  name                      = "sqs-${var.aws_shot_region}-${var.environment}-default-notification-email-local-beta"
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 0

  sqs_managed_sse_enabled = true

  tags = {
    Name = "sqs-${var.aws_shot_region}-${var.environment}-default-notification-email-local-beta",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }  
}

resource "aws_sqs_queue" "fifo_marketpalce_voucher_beta" {
  count = var.environment == "dev" ? 1:0

  name                      = "sqs-${var.aws_shot_region}-${var.environment}-fifo-marketplace-voucher-beta.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  deduplication_scope   = "messageGroup"
  fifo_throughput_limit = "perMessageGroupId"
  sqs_managed_sse_enabled = true

  tags = {
    Name = "sqs-${var.aws_shot_region}-${var.environment}-fifo-marketplace-voucher-beta.fifo",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }  
}

resource "aws_sqs_queue" "fifo_marketpalce_voucher_feature_queue_beta" {
  count = var.environment == "dev" ? 1:0

  name                      = "sqs-${var.aws_shot_region}-${var.environment}-fifo-marketplace-voucher-feature-beta.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  deduplication_scope   = "messageGroup"
  fifo_throughput_limit = "perMessageGroupId"
  sqs_managed_sse_enabled = true

  tags = {
    Name = "sqs-${var.aws_shot_region}-${var.environment}-fifo-marketplace-voucher-beta.fifo",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }  
}