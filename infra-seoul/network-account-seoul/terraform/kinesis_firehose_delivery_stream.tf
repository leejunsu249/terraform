## NFW Log

resource "aws_kinesis_firehose_delivery_stream" "nfw_alert" {
  name        = "firehose-${var.aws_shot_region}-${var.environment}-nfw-alert"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = data.terraform_remote_state.network.outputs.firehose_nfw_role_arn
    bucket_arn = "arn:aws:s3:::s3-an2-shd-nfw-logs"
    prefix     = "an2/alert/"

    processing_configuration {
      enabled = "false"
    }
  }

  tags = {
    Name               = "firehose-${var.aws_shot_region}-${var.environment}-nfw-alert",
    LogDeliveryEnabled = "true",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_kinesis_firehose_delivery_stream" "nfw_flow" {
  name        = "firehose-${var.aws_shot_region}-${var.environment}-nfw-flow"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = data.terraform_remote_state.network.outputs.firehose_nfw_role_arn
    bucket_arn = "arn:aws:s3:::s3-an2-shd-nfw-logs"
    prefix     = "an2/flow/"

    processing_configuration {
      enabled = "false"
    }
  }

  tags = {
    Name               = "firehose-${var.aws_shot_region}-${var.environment}-nfw-flow",
    LogDeliveryEnabled = "true",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}
