resource "aws_kinesis_firehose_delivery_stream" "delivery_stream_from_eks" {
  for_each = var.log_stream_services

  name        = "firehose-${var.aws_shot_region}-${var.environment}-${each.value.name}"
  destination = "elasticsearch"

  server_side_encryption {
    enabled = true
    key_type = "AWS_OWNED_CMK"
  }

  elasticsearch_configuration {
    domain_arn = aws_elasticsearch_domain.opensearch.arn
    role_arn   = aws_iam_role.firehose_opensearch_role.arn
    index_name = each.value.name
    index_rotation_period = "OneDay"
    s3_backup_mode = "AllDocuments"
    buffering_interval = 60
    
    vpc_config {
      subnet_ids         = var.subnet_ids
      security_group_ids = [aws_security_group.opensearch.id]
      role_arn           = aws_iam_role.firehose_opensearch_role.arn
    }
  }

  s3_configuration {
    role_arn           = aws_iam_role.firehose_opensearch_role.arn
    bucket_arn         = "arn:aws:s3:::${var.service_log_backup_bucket_name}"
    buffer_size        = 10
    buffer_interval    = 400
    compression_format = "GZIP"
    prefix = "${var.environment}/${each.value.name}/"
    error_output_prefix = "${var.environment}/${each.value.name}/error"
  }

  tags = {
    Name               = "firehose-${var.aws_shot_region}-${var.environment}-${each.value.name}",
    LogDeliveryEnabled = "true",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_kinesis_firehose_delivery_stream" "delivery_stream_from_eks_kms" {
  name        = "firehose-${var.aws_shot_region}-${var.environment}-kms"
  destination = "elasticsearch"

  server_side_encryption {
    enabled = true
    key_type = "AWS_OWNED_CMK"
  }

  elasticsearch_configuration {
    domain_arn = aws_elasticsearch_domain.opensearch.arn
    role_arn   = aws_iam_role.firehose_opensearch_role.arn
    index_name = "kms"
    index_rotation_period = "OneDay"
    s3_backup_mode = "AllDocuments"
    buffering_interval = 60
    
    vpc_config {
      subnet_ids         = var.subnet_ids
      security_group_ids = [aws_security_group.opensearch.id]
      role_arn           = aws_iam_role.firehose_opensearch_role.arn
    }

    processing_configuration {
      enabled = true
      processors {
        type = "Lambda"
        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "arn:aws:lambda:${var.aws_region}:${var.aws_account_number}:function:lambda-ue2-firehose-kms:$LATEST"
        }
        parameters {
          parameter_name  = "BufferSizeInMBs"
          parameter_value = "1"
        }
        parameters {
          parameter_name  = "BufferIntervalInSeconds"
          parameter_value = "60"
        }
      }
    }
  }

  s3_configuration {
    role_arn           = aws_iam_role.firehose_opensearch_role.arn
    bucket_arn         = "arn:aws:s3:::${var.service_log_backup_bucket_name}"
    buffer_size        = 10
    buffer_interval    = 400
    compression_format = "GZIP"
    prefix = "${var.environment}/kms/"
    error_output_prefix = "${var.environment}/kms/error"
  }

  tags = {
    Name               = "firehose-${var.aws_shot_region}-${var.environment}-kms",
    LogDeliveryEnabled = "true",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_kinesis_firehose_delivery_stream" "delivery_stream_from_eks_peer" {
  name        = "firehose-${var.aws_shot_region}-${var.environment}-peer"
  destination = "elasticsearch"

  server_side_encryption {
    enabled = true
    key_type = "AWS_OWNED_CMK"
  }

  elasticsearch_configuration {
    domain_arn = aws_elasticsearch_domain.opensearch.arn
    role_arn   = aws_iam_role.firehose_opensearch_role.arn
    index_name = "peer"
    index_rotation_period = "OneDay"
    s3_backup_mode = "AllDocuments"
    buffering_interval = 60
    
    vpc_config {
      subnet_ids         = var.subnet_ids
      security_group_ids = [aws_security_group.opensearch.id]
      role_arn           = aws_iam_role.firehose_opensearch_role.arn
    }

    processing_configuration {
      enabled = true
      processors {
        type = "Lambda"
        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "arn:aws:lambda:${var.aws_region}:${var.aws_account_number}:function:lambda-ue2-firehose-peer:$LATEST"
        }
        parameters {
          parameter_name  = "BufferSizeInMBs"
          parameter_value = "1"
        }
        parameters {
          parameter_name  = "BufferIntervalInSeconds"
          parameter_value = "60"
        }
      }
    }
  }

  s3_configuration {
    role_arn           = aws_iam_role.firehose_opensearch_role.arn
    bucket_arn         = "arn:aws:s3:::${var.service_log_backup_bucket_name}"
    buffer_size        = 10
    buffer_interval    = 400
    compression_format = "GZIP"
    prefix = "${var.environment}/peer/"
    error_output_prefix = "${var.environment}/peer/error"
  }

  tags = {
    Name               = "firehose-${var.aws_shot_region}-${var.environment}-peer",
    LogDeliveryEnabled = "true",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_kinesis_firehose_delivery_stream" "delivery_stream_from_eks_orderer" {
  name        = "firehose-${var.aws_shot_region}-${var.environment}-orderer"
  destination = "elasticsearch"

  server_side_encryption {
    enabled = true
    key_type = "AWS_OWNED_CMK"
  }

  elasticsearch_configuration {
    domain_arn = aws_elasticsearch_domain.opensearch.arn
    role_arn   = aws_iam_role.firehose_opensearch_role.arn
    index_name = "orderer"
    index_rotation_period = "OneDay"
    s3_backup_mode = "AllDocuments"
    buffering_interval = 60
    
    vpc_config {
      subnet_ids         = var.subnet_ids
      security_group_ids = [aws_security_group.opensearch.id]
      role_arn           = aws_iam_role.firehose_opensearch_role.arn
    }

    processing_configuration {
      enabled = true
      processors {
        type = "Lambda"
        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "arn:aws:lambda:${var.aws_region}:${var.aws_account_number}:function:lambda-ue2-firehose-orderer:$LATEST"
        }
        parameters {
          parameter_name  = "BufferSizeInMBs"
          parameter_value = "1"
        }
        parameters {
          parameter_name  = "BufferIntervalInSeconds"
          parameter_value = "60"
        }
      }
    }
  }

  s3_configuration {
    role_arn           = aws_iam_role.firehose_opensearch_role.arn
    bucket_arn         = "arn:aws:s3:::${var.service_log_backup_bucket_name}"
    buffer_size        = 10
    buffer_interval    = 400
    compression_format = "GZIP"
    prefix = "${var.environment}/orderer/"
    error_output_prefix = "${var.environment}/orderer/error"
  }

  tags = {
    Name               = "firehose-${var.aws_shot_region}-${var.environment}-orderer",
    LogDeliveryEnabled = "true",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_kinesis_firehose_delivery_stream" "delivery_stream_from_eks_rest1" {
  name        = "firehose-${var.aws_shot_region}-${var.environment}-mona-rest1"
  destination = "elasticsearch"

  server_side_encryption {
    enabled = true
    key_type = "AWS_OWNED_CMK"
  }

  elasticsearch_configuration {
    domain_arn = aws_elasticsearch_domain.opensearch.arn
    role_arn   = aws_iam_role.firehose_opensearch_role.arn
    index_name = "mona-rest"
    index_rotation_period = "OneDay"
    s3_backup_mode = "AllDocuments"
    buffering_interval = 60
    
    vpc_config {
      subnet_ids         = var.subnet_ids
      security_group_ids = [aws_security_group.opensearch.id]
      role_arn           = aws_iam_role.firehose_opensearch_role.arn
    }

    processing_configuration {
      enabled = true
      processors {
        type = "Lambda"
        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "arn:aws:lambda:${var.aws_region}:${var.aws_account_number}:function:lambda-ue2-firehose-mona-rest:$LATEST"
        }
        parameters {
          parameter_name  = "BufferSizeInMBs"
          parameter_value = "1"
        }
        parameters {
          parameter_name  = "BufferIntervalInSeconds"
          parameter_value = "60"
        }
      }
    }
  }

  s3_configuration {
    role_arn           = aws_iam_role.firehose_opensearch_role.arn
    bucket_arn         = "arn:aws:s3:::${var.service_log_backup_bucket_name}"
    buffer_size        = 10
    buffer_interval    = 400
    compression_format = "GZIP"
    prefix = "${var.environment}/mona-rest1/"
    error_output_prefix = "${var.environment}/mona-rest1/error"
  }

  tags = {
    Name               = "firehose-${var.aws_shot_region}-${var.environment}-mona-rest1",
    LogDeliveryEnabled = "true",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_kinesis_firehose_delivery_stream" "delivery_stream_from_eks_rest2" {
  name        = "firehose-${var.aws_shot_region}-${var.environment}-mona-rest2"
  destination = "elasticsearch"

  server_side_encryption {
    enabled = true
    key_type = "AWS_OWNED_CMK"
  }

  elasticsearch_configuration {
    domain_arn = aws_elasticsearch_domain.opensearch.arn
    role_arn   = aws_iam_role.firehose_opensearch_role.arn
    index_name = "mona-rest"
    index_rotation_period = "OneDay"
    s3_backup_mode = "AllDocuments"
    buffering_interval = 60
    
    vpc_config {
      subnet_ids         = var.subnet_ids
      security_group_ids = [aws_security_group.opensearch.id]
      role_arn           = aws_iam_role.firehose_opensearch_role.arn
    }

    processing_configuration {
      enabled = true
      processors {
        type = "Lambda"
        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "arn:aws:lambda:${var.aws_region}:${var.aws_account_number}:function:lambda-ue2-firehose-mona-rest:$LATEST"
        }
        parameters {
          parameter_name  = "BufferSizeInMBs"
          parameter_value = "1"
        }
        parameters {
          parameter_name  = "BufferIntervalInSeconds"
          parameter_value = "60"
        }
      }
    }
  }

  s3_configuration {
    role_arn           = aws_iam_role.firehose_opensearch_role.arn
    bucket_arn         = "arn:aws:s3:::${var.service_log_backup_bucket_name}"
    buffer_size        = 10
    buffer_interval    = 400
    compression_format = "GZIP"
    prefix = "${var.environment}/mona-rest2/"
    error_output_prefix = "${var.environment}/mona-rest2/error"
  }

  tags = {
    Name               = "firehose-${var.aws_shot_region}-${var.environment}-mona-rest2",
    LogDeliveryEnabled = "true",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}