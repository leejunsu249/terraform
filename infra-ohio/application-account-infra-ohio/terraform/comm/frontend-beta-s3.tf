# fe-marketplace
resource "aws_s3_bucket" "fe-marketplace-next_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-marketplace-next"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-marketplace-next",
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fe-marketplace-next_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = aws_s3_bucket.fe-marketplace-next_bucket[0].bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "fe-marketplace-next_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = aws_s3_bucket.fe-marketplace-next_bucket[0].id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "fe-marketplace-next_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = aws_s3_bucket.fe-marketplace-next_bucket[0].id
  policy = data.aws_iam_policy_document.fe-marketplace-next_bucket_policy[0].json
}

data "aws_iam_policy_document" "fe-marketplace-next_bucket_policy" {
  count = var.environment == "dev" ? 1:0

  source_policy_documents = [
    data.aws_iam_policy_document.fe-marketplace-next_bucket[0].json,
    data.template_file.fe-marketplace-next_bucket_s3_secure_transport[0].rendered
  ]
}

data "template_file" "fe-marketplace-next_bucket_s3_secure_transport" {
  count = var.environment == "dev" ? 1:0

  template = "${file("../../template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.fe-marketplace-next_bucket[0].arn}"
  }
}

data "aws_iam_policy_document" "fe-marketplace-next_bucket" {
  count = var.environment == "dev" ? 1:0

  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.cloudfront_marketplace_next_oai}"]
    }

    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.fe-marketplace-next_bucket[0].id}/*",
      "arn:aws:s3:::${aws_s3_bucket.fe-marketplace-next_bucket[0].id}"
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "fe-marketplace-next_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = aws_s3_bucket.fe-marketplace-next_bucket[0].id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# fe-creatoradmin
resource "aws_s3_bucket" "fe-creator-next_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-creator-next"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-creator-next"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fe-creator-next_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = aws_s3_bucket.fe-creator-next_bucket[0].bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "fe-creator-next_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = aws_s3_bucket.fe-creator-next_bucket[0].id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "fe-creator-next_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = aws_s3_bucket.fe-creator-next_bucket[0].id
  policy = data.aws_iam_policy_document.fe-creator-next_bucket_policy[0].json
}

data "aws_iam_policy_document" "fe-creator-next_bucket_policy" {
  count = var.environment == "dev" ? 1:0

  source_policy_documents = [
    data.aws_iam_policy_document.fe-creator-next_bucket[0].json,
    data.template_file.fe-creator-next_bucket_s3_secure_transport[0].rendered
  ]
}

data "template_file" "fe-creator-next_bucket_s3_secure_transport" {
  count = var.environment == "dev" ? 1:0

  template = "${file("../../template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.fe-creator-next_bucket[0].arn}"
  }
}

data "aws_iam_policy_document" "fe-creator-next_bucket" {
  count = var.environment == "dev" ? 1:0

  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.cloudfront_creatoradmin_next_oai}"]
    }

    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.fe-creator-next_bucket[0].id}/*",
      "arn:aws:s3:::${aws_s3_bucket.fe-creator-next_bucket[0].id}"
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "fe-creator-next_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = aws_s3_bucket.fe-creator-next_bucket[0].id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# fe-systemadmin
resource "aws_s3_bucket" "fe-systemadmin-next_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-systemadmin-next"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-systemadmin-next",
    System                      = "systemadmin",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fe-systemadmin-next_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = aws_s3_bucket.fe-systemadmin-next_bucket[0].bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "fe-systemadmin-next_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = aws_s3_bucket.fe-systemadmin-next_bucket[0].id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "fe-systemadmin-next_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = aws_s3_bucket.fe-systemadmin-next_bucket[0].id
  policy = data.aws_iam_policy_document.fe-systemadmin-next_bucket_policy[0].json
}

data "aws_iam_policy_document" "fe-systemadmin-next_bucket_policy" {
  count = var.environment == "dev" ? 1:0

  source_policy_documents = [
    data.aws_iam_policy_document.fe-systemadmin-next_bucket[0].json,
    data.template_file.fe-systemadmin-next_bucket_s3_secure_transport[0].rendered
  ]
}

data "template_file" "fe-systemadmin-next_bucket_s3_secure_transport" {
  count = var.environment == "dev" ? 1:0

  template = "${file("../../template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.fe-systemadmin-next_bucket[0].arn}"
  }
}

data "aws_iam_policy_document" "fe-systemadmin-next_bucket" {
  count = var.environment == "dev" ? 1:0

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
      "arn:aws:s3:::${aws_s3_bucket.fe-systemadmin-next_bucket[0].id}/*",
      "arn:aws:s3:::${aws_s3_bucket.fe-systemadmin-next_bucket[0].id}"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceVpce"

      values = [ 
        data.terraform_remote_state.network.outputs.s3_vpc_gw_id
      ]
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "fe-systemadmin-next_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = aws_s3_bucket.fe-systemadmin-next_bucket[0].id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}