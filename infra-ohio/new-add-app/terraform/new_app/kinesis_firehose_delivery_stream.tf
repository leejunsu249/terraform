resource "aws_kinesis_firehose_delivery_stream" "delivery_stream_from_eks" {
  for_each = var.environment == "prd" ? var.log_stream_services : {}

  name        = "firehose-${var.aws_shot_region}-${var.env_nprd}-${each.value.name}"
  destination = "elasticsearch"

  server_side_encryption {
    enabled = true
    key_type = "AWS_OWNED_CMK"
  }

  elasticsearch_configuration {
    domain_arn = var.elasticsearch_domain_arn
    role_arn   = var.firehose_opensearch_role_arn
    index_name = each.value.name
    index_rotation_period = "OneDay"
    s3_backup_mode = "AllDocuments"
    buffering_interval = 60
    
    vpc_config {
      subnet_ids         = var.subnet_ids
      security_group_ids = [var.aws_security_group_opensearch]
      role_arn           = var.firehose_opensearch_role_arn
    }
  }

  s3_configuration {
    role_arn           = "${var.firehose_opensearch_role_arn}"
    bucket_arn         = "arn:aws:s3:::${var.service_log_backup_bucket_name}"
    buffer_size        = 10
    buffer_interval    = 400
    compression_format = "GZIP"
    prefix = "${var.env_nprd}/${each.value.name}/"
    error_output_prefix = "${var.env_nprd}/${each.value.name}/error"
  }

  tags = {
    Name               = "firehose-${var.aws_shot_region}-${var.env_nprd}-${each.value.name}",
    LogDeliveryEnabled = "true",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

