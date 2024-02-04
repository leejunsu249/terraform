# fe-homepage
resource "aws_s3_bucket" "fe-homepage_bucket" {
  count = var.environment == "prd" ? 1 : 0

  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-homepage"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-homepage",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fe-homepage_bucket" {
  count = var.environment == "prd" ? 1 : 0

  bucket = aws_s3_bucket.fe-homepage_bucket[0].bucket

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "fe-homepage_bucket" {
  count = var.environment == "prd" ? 1 : 0

  bucket = aws_s3_bucket.fe-homepage_bucket[0].id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "fe-homepage_bucket" {
  count = var.environment == "prd" ? 1 : 0

  bucket = aws_s3_bucket.fe-homepage_bucket[0].id
  policy = data.aws_iam_policy_document.fe-homepage_bucket_policy[0].json
}

data "aws_iam_policy_document" "fe-homepage_bucket_policy" {
  count = var.environment == "prd" ? 1 : 0

  source_policy_documents = [
    data.aws_iam_policy_document.fe-homepage_bucket[0].json,
    data.template_file.fe-homepage_bucket_s3_secure_transport[0].rendered
  ]
}

data "template_file" "fe-homepage_bucket_s3_secure_transport" {
  count = var.environment == "prd" ? 1 : 0

  template = file("../../template/s3-secure-transport.json.tpl")

  vars = {
    resource = "${aws_s3_bucket.fe-homepage_bucket[0].arn}"
  }
}

data "aws_iam_policy_document" "fe-homepage_bucket" {
  count = var.environment == "prd" ? 1 : 0

  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.cloudfront_homepage_oai}"]
    }

    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.fe-homepage_bucket[0].id}/*",
      "arn:aws:s3:::${aws_s3_bucket.fe-homepage_bucket[0].id}"
    ]
  }
}

resource "aws_s3_bucket_cors_configuration" "fe-homepage_bucket" {
  count = var.environment == "prd" ? 1 : 0

  bucket = aws_s3_bucket.fe-homepage_bucket[0].bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["Access-Control-Allow-Origin", "x-amz-server-side-encryption", "x-amz-request-id", "x-amz-id-2"]
  }
}

resource "aws_s3_bucket_ownership_controls" "fe-homepage_bucket" {
  count = var.environment == "prd" ? 1 : 0

  bucket = aws_s3_bucket.fe-homepage_bucket[0].id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}