# fe-marketplace
resource "aws_s3_bucket" "fe-marketplace_bucket" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-marketplace"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-marketplace",
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fe-marketplace_bucket" {
  bucket = aws_s3_bucket.fe-marketplace_bucket.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "fe-marketplace_bucket" {
  bucket = aws_s3_bucket.fe-marketplace_bucket.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "fe-marketplace_bucket" {
  bucket = aws_s3_bucket.fe-marketplace_bucket.id
  policy = data.aws_iam_policy_document.fe-marketplace_bucket_policy.json
}

data "aws_iam_policy_document" "fe-marketplace_bucket_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.fe-marketplace_bucket.json,
    data.template_file.fe-marketplace_bucket_s3_secure_transport.rendered
  ]
}

data "template_file" "fe-marketplace_bucket_s3_secure_transport" {
  template = "${file("../../template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.fe-marketplace_bucket.arn}"
  }
}

data "aws_iam_policy_document" "fe-marketplace_bucket" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.cloudfront_marketplace_oai}"]
    }

    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.fe-marketplace_bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.fe-marketplace_bucket.id}"
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "fe-marketplace_bucket" {
  bucket = aws_s3_bucket.fe-marketplace_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# fe-creatoradmin
resource "aws_s3_bucket" "fe-creator_bucket" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-creator"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-creator"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fe-creator_bucket" {
  bucket = aws_s3_bucket.fe-creator_bucket.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "fe-creator_bucket" {
  bucket = aws_s3_bucket.fe-creator_bucket.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "fe-creator_bucket" {
  bucket = aws_s3_bucket.fe-creator_bucket.id
  policy = data.aws_iam_policy_document.fe-creator_bucket_policy.json
}

data "aws_iam_policy_document" "fe-creator_bucket_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.fe-creator_bucket.json,
    data.template_file.fe-creator_bucket_s3_secure_transport.rendered
  ]
}

data "template_file" "fe-creator_bucket_s3_secure_transport" {
  template = "${file("../../template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.fe-creator_bucket.arn}"
  }
}

data "aws_iam_policy_document" "fe-creator_bucket" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.cloudfront_creatoradmin_oai}"]
    }

    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.fe-creator_bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.fe-creator_bucket.id}"
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "fe-creator_bucket" {
  bucket = aws_s3_bucket.fe-creator_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# fe-systemadmin
resource "aws_s3_bucket" "fe-systemadmin_bucket" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-systemadmin"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-systemadmin",
    System                      = "systemadmin",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fe-systemadmin_bucket" {
  bucket = aws_s3_bucket.fe-systemadmin_bucket.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "fe-systemadmin_bucket" {
  bucket = aws_s3_bucket.fe-systemadmin_bucket.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "fe-systemadmin_bucket" {
  bucket = aws_s3_bucket.fe-systemadmin_bucket.id
  policy = data.aws_iam_policy_document.fe-systemadmin_bucket_policy.json
}

data "aws_iam_policy_document" "fe-systemadmin_bucket_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.fe-systemadmin_bucket.json,
    data.template_file.fe-systemadmin_bucket_s3_secure_transport.rendered
  ]
}

data "template_file" "fe-systemadmin_bucket_s3_secure_transport" {
  template = "${file("../../template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.fe-systemadmin_bucket.arn}"
  }
}

data "aws_iam_policy_document" "fe-systemadmin_bucket" {
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
      "arn:aws:s3:::${aws_s3_bucket.fe-systemadmin_bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.fe-systemadmin_bucket.id}"
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

resource "aws_s3_bucket_ownership_controls" "fe-systemadmin_bucket" {
  bucket = aws_s3_bucket.fe-systemadmin_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}