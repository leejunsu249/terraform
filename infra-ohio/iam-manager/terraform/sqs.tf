resource "aws_sqs_queue" "notification_default_queue" {
  for_each = var.users

  provider  = aws.dev

  name                      = "sqs-ue2-dev-default-notification-email-${each.key}"
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 0

  sqs_managed_sse_enabled = true

  tags = {
    Name = "sqs-ue2-dev-default-notification-email"
    User = each.key,
    System                      = "notification",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_sqs_queue" "fifo_marketpalce_voucher" {
  for_each = var.users

  provider  = aws.dev

  name                        = "sqs-ue2-dev-fifo-marketplace-voucher-${each.key}.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  deduplication_scope   = "messageGroup"
  fifo_throughput_limit = "perMessageGroupId"
  sqs_managed_sse_enabled = true

  tags = {
    Name = "sqs-ue2-dev-fifo-marketplace-voucher.fifo"
    User = each.key,
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}
