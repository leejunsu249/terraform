## WAF Log

resource "aws_kinesis_firehose_delivery_stream" "waf_non_prd" {
  provider    = aws.virginia
  name        = "aws-waf-logs-non-prd"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_waf_role.arn
    bucket_arn = "arn:aws:s3:::aws-waf-logs-naemo"
    prefix     = "non-prd/"

    processing_configuration {
      enabled = "false"
    }
  }

  tags = {
    Name               = "firehose-${var.aws_shot_region}-${var.environment}-aws-waf-logs-non-prd",
    LogDeliveryEnabled = "true",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_kinesis_firehose_delivery_stream" "waf_prd" {
  provider    = aws.virginia
  name        = "aws-waf-logs-prd"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_waf_role.arn
    bucket_arn = "arn:aws:s3:::aws-waf-logs-naemo"
    prefix     = "prd/"

    processing_configuration {
      enabled = "false"
    }
  }

  tags = {
    Name               = "firehose-${var.aws_shot_region}-${var.environment}-aws-waf-logs-prd",
    LogDeliveryEnabled = "true",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

## NFW Log

resource "aws_kinesis_firehose_delivery_stream" "nfw_alert" {
  name        = "firehose-${var.aws_shot_region}-${var.environment}-nfw-alert"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_nfw_role.arn
    bucket_arn = "arn:aws:s3:::s3-an2-shd-nfw-logs"
    prefix     = "ue2/alert/"

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
    role_arn   = aws_iam_role.firehose_nfw_role.arn
    bucket_arn = "arn:aws:s3:::s3-an2-shd-nfw-logs"
    prefix     = "ue2/flow/"

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
