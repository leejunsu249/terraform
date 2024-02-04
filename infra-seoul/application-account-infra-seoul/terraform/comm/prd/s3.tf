# fe-centralwallet
resource "aws_s3_bucket" "fe-centralwallet_bucket" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-centralwallet"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-centralwallet",
    System                      = "centralwallet",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fe-centralwallet_bucket" {
  bucket = aws_s3_bucket.fe-centralwallet_bucket.bucket

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "fe-centralwallet_bucket" {
  bucket = aws_s3_bucket.fe-centralwallet_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "fe-centralwallet_bucket" {
  bucket = aws_s3_bucket.fe-centralwallet_bucket.id
  policy = data.aws_iam_policy_document.fe-centralwallet_bucket_policy.json
}

data "aws_iam_policy_document" "fe-centralwallet_bucket_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.fe-centralwallet_bucket.json,
    data.template_file.fe-centralwallet_bucket_s3_secure_transport.rendered
  ]
}

data "template_file" "fe-centralwallet_bucket_s3_secure_transport" {
  template = file("../../../template/s3-secure-transport.json.tpl")

  vars = {
    resource = "${aws_s3_bucket.fe-centralwallet_bucket.arn}"
  }
}

data "aws_iam_policy_document" "fe-centralwallet_bucket" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.fe-centralwallet_bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.fe-centralwallet_bucket.id}"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceVpce"

      values = [
        data.terraform_remote_state.network.outputs.wallet_s3_vpc_gw_id
      ]
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "fe-centralwallet_bucket" {
  bucket = aws_s3_bucket.fe-centralwallet_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}


#### heap dump bucket ####

resource "aws_s3_bucket" "heap_dump_bucket" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-heap-dump"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-heap-dump",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "heap_dump_bucket" {
  bucket = aws_s3_bucket.heap_dump_bucket.bucket

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "heap_dump_bucket" {
  bucket = aws_s3_bucket.heap_dump_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "heap_dump_bucket" {
  bucket = aws_s3_bucket.heap_dump_bucket.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

resource "aws_s3_bucket_policy" "heap_dump_bucket" {
  bucket = aws_s3_bucket.heap_dump_bucket.id
  policy = data.aws_iam_policy_document.heap_dump_bucket_policy.json
}

data "aws_iam_policy_document" "heap_dump_bucket_policy" {
  source_policy_documents = [
    data.template_file.heap_dump_bucket_s3_secure_transport.rendered
  ]
}

data "template_file" "heap_dump_bucket_s3_secure_transport" {
  template = file("../../../template/s3-secure-transport.json.tpl")

  vars = {
    resource = "${aws_s3_bucket.heap_dump_bucket.arn}"
  }
}

resource "aws_s3_bucket_ownership_controls" "heap_dump_bucket" {
  bucket = aws_s3_bucket.heap_dump_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

#### bcs deploy bucket ####
resource "aws_s3_bucket" "bcs_deploy_bucket" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-bcs-deploy"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-bcs-deploy",
    System                      = "bcs",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bcs_deploy_bucket" {
  bucket = aws_s3_bucket.bcs_deploy_bucket.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "bcs_deploy_bucket" {
  bucket = aws_s3_bucket.bcs_deploy_bucket.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "bcs_deploy_bucket" {
  bucket = aws_s3_bucket.bcs_deploy_bucket.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

resource "aws_s3_bucket_policy" "bcs_deploy_bucket" {
  bucket = aws_s3_bucket.bcs_deploy_bucket.id
  policy = data.aws_iam_policy_document.bcs_deploy_bucket_policy.json
}

data "aws_iam_policy_document" "bcs_deploy_bucket_policy" {
  source_policy_documents = [
    data.template_file.bcs_deploy_bucket_s3_secure_transport.rendered
  ]
}

data "template_file" "bcs_deploy_bucket_s3_secure_transport" {
  template = "${file("../../../template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.bcs_deploy_bucket.arn}"
  }
}

resource "aws_s3_bucket_ownership_controls" "bcs_deploy_bucket" {
  bucket = aws_s3_bucket.bcs_deploy_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}


#### wallet deploy bucket ####
resource "aws_s3_bucket" "wallet_deploy_bucket" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-wallet-deploy"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-wallet-deploy",
    System                      = "kms",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "wallet_deploy_bucket" {
  bucket = aws_s3_bucket.wallet_deploy_bucket.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "wallet_deploy_bucket" {
  bucket = aws_s3_bucket.wallet_deploy_bucket.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "wallet_deploy_bucket" {
  bucket = aws_s3_bucket.wallet_deploy_bucket.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

resource "aws_s3_bucket_policy" "wallet_deploy_bucket" {
  bucket = aws_s3_bucket.wallet_deploy_bucket.id
  policy = data.aws_iam_policy_document.wallet_deploy_bucket_policy.json
}

data "aws_iam_policy_document" "wallet_deploy_bucket_policy" {
  source_policy_documents = [
    data.template_file.wallet_deploy_bucket_s3_secure_transport.rendered
  ]
}

data "template_file" "wallet_deploy_bucket_s3_secure_transport" {
  template = "${file("../../../template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.wallet_deploy_bucket.arn}"
  }
}

resource "aws_s3_bucket_ownership_controls" "wallet_deploy_bucket" {
  bucket = aws_s3_bucket.wallet_deploy_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

