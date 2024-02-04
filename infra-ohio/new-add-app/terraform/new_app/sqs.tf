resource "aws_sqs_queue" "reward-queue" {
  name                      = "sqs-${var.aws_shot_region}-${var.environment}-default-reward-event"
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 345600
  receive_wait_time_seconds = 0

  sqs_managed_sse_enabled = true

  tags = {
    Name = "sqs-${var.aws_shot_region}-${var.environment}-default-reward-event",
    System                      = "reward-event",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}
