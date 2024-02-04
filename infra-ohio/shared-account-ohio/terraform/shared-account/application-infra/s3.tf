resource "aws_s3_bucket" "gitlab_cache" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-gitlab-cache"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-gitlab-cache"
  }
}

resource "aws_s3_bucket_public_access_block" "gitlab_cache" {
  bucket = aws_s3_bucket.gitlab_cache.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "gitlab_cache" {
  bucket = aws_s3_bucket.gitlab_cache.bucket

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "gitlab_cache_s3_policy" {
  bucket = aws_s3_bucket.gitlab_cache.id
  policy = data.template_file.gitlab_cache_s3_secure_transport.rendered
}

data "template_file" "gitlab_cache_s3_secure_transport" {
  template = file("template/s3-secure-transport.json.tpl")

  vars = {
    resource = "${aws_s3_bucket.gitlab_cache.arn}"
  }
}

resource "aws_s3_bucket" "gitlab_artifact" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-gitlab-artifact"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-gitlab-artifact"
  }
}

resource "aws_s3_bucket_public_access_block" "gitlab_artifact" {
  bucket = aws_s3_bucket.gitlab_artifact.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "gitlab_artifact" {
  bucket = aws_s3_bucket.gitlab_artifact.bucket

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "gitlab_artifact_s3_policy" {
  bucket = aws_s3_bucket.gitlab_artifact.id
  policy = data.template_file.gitlab_artifact_s3_secure_transport.rendered
}

data "template_file" "gitlab_artifact_s3_secure_transport" {
  template = file("template/s3-secure-transport.json.tpl")

  vars = {
    resource = "${aws_s3_bucket.gitlab_artifact.arn}"
  }
}

resource "aws_s3_bucket" "gitlab_backup" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-gitlab-backup"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-gitlab-backup"
  }
}

resource "aws_s3_bucket_public_access_block" "gitlab_backup" {
  bucket = aws_s3_bucket.gitlab_backup.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "gitlab_backup" {
  bucket = aws_s3_bucket.gitlab_backup.bucket

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "gitlab_backup_s3_policy" {
  bucket = aws_s3_bucket.gitlab_backup.id
  policy = data.template_file.gitlab_backup_s3_secure_transport.rendered
}

data "template_file" "gitlab_backup_s3_secure_transport" {
  template = file("template/s3-secure-transport.json.tpl")

  vars = {
    resource = "${aws_s3_bucket.gitlab_backup.arn}"
  }
}

resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-cloudtrail-logs"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-cloudtrail-logs"
  }
}

resource "aws_s3_bucket_public_access_block" "cloudtrail_logs" {
  bucket = aws_s3_bucket.cloudtrail_logs.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cloudtrail_logs" {
  bucket = aws_s3_bucket.cloudtrail_logs.bucket

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "cloudtrail_logs_s3_policy" {
  bucket = aws_s3_bucket.cloudtrail_logs.id
  policy = data.aws_iam_policy_document.cloudtrail_policy.json
}

data "aws_iam_policy_document" "cloudtrail_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.cloudtrail_logs_allow_access_from_another_account.json,
    data.template_file.cloudtrail_s3_secure_transport.rendered
  ]
}

data "aws_iam_policy_document" "cloudtrail_logs_allow_access_from_another_account" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      aws_s3_bucket.cloudtrail_logs.arn,
      "${aws_s3_bucket.cloudtrail_logs.arn}/dev/AWSLogs/385866877617/*",
      "${aws_s3_bucket.cloudtrail_logs.arn}/stg/AWSLogs/087942668956/*",
      "${aws_s3_bucket.cloudtrail_logs.arn}/prd/AWSLogs/908317417455/*",
      "${aws_s3_bucket.cloudtrail_logs.arn}/net/AWSLogs/351894368755/*",
      "${aws_s3_bucket.cloudtrail_logs.arn}/shd/AWSLogs/676826599814/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = ["bucket-owner-full-control"]
    }
  }

  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl"
    ]

    resources = [
      aws_s3_bucket.cloudtrail_logs.arn
    ]
  }
}

data "template_file" "cloudtrail_s3_secure_transport" {
  template = file("template/s3-secure-transport.json.tpl")

  vars = {
    resource = "${aws_s3_bucket.cloudtrail_logs.arn}"
  }
}

resource "aws_s3_bucket" "elb_logs" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-elb-logs"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-elb-logs"
  }
}

resource "aws_s3_bucket_public_access_block" "elb_logs" {
  bucket = aws_s3_bucket.elb_logs.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "elb_logs" {
  bucket = aws_s3_bucket.elb_logs.bucket

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "elb_logs_s3_policy" {
  bucket = aws_s3_bucket.elb_logs.id
  policy = data.aws_iam_policy_document.elb_policy.json
}

data "aws_iam_policy_document" "elb_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.elb_logs_allow_access_from_another_account.json,
    data.template_file.elb_s3_delivery_log.rendered,
    data.template_file.elb_s3_secure_transport.rendered
  ]
}

data "aws_iam_policy_document" "elb_logs_allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::033677994240:root", "arn:aws:iam::600734575887:root"]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      aws_s3_bucket.elb_logs.arn,
      "${aws_s3_bucket.elb_logs.arn}/dev/*",
      "${aws_s3_bucket.elb_logs.arn}/stg/*",
      "${aws_s3_bucket.elb_logs.arn}/prd/*",
      "${aws_s3_bucket.elb_logs.arn}/net/*",
      "${aws_s3_bucket.elb_logs.arn}/shd/*"
    ]
  }
}

data "template_file" "elb_s3_delivery_log" {
  template = file("template/s3-delivery-log-policy.json.tpl")

  vars = {
    resource = "${aws_s3_bucket.elb_logs.arn}"
  }
}

data "template_file" "elb_s3_secure_transport" {
  template = file("template/s3-secure-transport.json.tpl")

  vars = {
    resource = "${aws_s3_bucket.elb_logs.arn}"
  }
}

resource "aws_s3_bucket" "flow_logs" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-flow-logs"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-flow-logs"
  }
}

resource "aws_s3_bucket_public_access_block" "flow_logs" {
  bucket = aws_s3_bucket.flow_logs.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "flow_logs" {
  bucket = aws_s3_bucket.flow_logs.bucket

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "flow_logs_s3_policy" {
  bucket = aws_s3_bucket.flow_logs.id
  policy = data.aws_iam_policy_document.flow_policy.json
}

data "aws_iam_policy_document" "flow_policy" {
  source_policy_documents = [
    data.template_file.flow_s3_delivery_log.rendered,
    data.template_file.flow_s3_secure_transport.rendered
  ]
}

data "template_file" "flow_s3_delivery_log" {
  template = file("template/s3-delivery-log-policy.json.tpl")

  vars = {
    resource = "${aws_s3_bucket.flow_logs.arn}"
  }
}

data "template_file" "flow_s3_secure_transport" {
  template = file("template/s3-secure-transport.json.tpl")

  vars = {
    resource = "${aws_s3_bucket.flow_logs.arn}"
  }
}

resource "aws_s3_bucket" "cfnt_logs" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-cfnt-logs"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-cfnt-logs"
  }
}

resource "aws_s3_bucket_public_access_block" "cfnt_logs" {
  bucket = aws_s3_bucket.cfnt_logs.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cfnt_logs" {
  bucket = aws_s3_bucket.cfnt_logs.bucket

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "cfnt_logs_s3_policy" {
  bucket = aws_s3_bucket.cfnt_logs.id
  policy = data.aws_iam_policy_document.cfnt_policy.json
}

data "aws_iam_policy_document" "cfnt_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.cfnt_logs_allow_access_from_another_account.json,
    data.template_file.cfnt_s3_secure_transport.rendered
  ]
}

data "aws_iam_policy_document" "cfnt_logs_allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["351894368755"]
    }

    actions = [
      "s3:GetBucketAcl",
      "s3:PutBucketACL"
    ]

    resources = [
      aws_s3_bucket.cfnt_logs.arn
    ]
  }
}

data "template_file" "cfnt_s3_secure_transport" {
  template = file("template/s3-secure-transport.json.tpl")

  vars = {
    resource = "${aws_s3_bucket.cfnt_logs.arn}"
  }
}

## WAF logging bucket

resource "aws_s3_bucket" "waf_logs" {
  bucket = "aws-waf-logs-naemo"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-waf-logs"
  }
}

resource "aws_s3_bucket_public_access_block" "waf_logs" {
  bucket = aws_s3_bucket.waf_logs.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "waf_logs" {
  bucket = aws_s3_bucket.waf_logs.bucket

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "waf_logs_s3_policy" {
  bucket = aws_s3_bucket.waf_logs.id
  policy = data.aws_iam_policy_document.waf_policy.json
}

data "aws_iam_policy_document" "waf_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.waf_logs_allow_access_from_another_account.json,
    data.template_file.waf_s3_secure_transport.rendered
  ]
}

data "aws_iam_policy_document" "waf_logs_allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::351894368755:role/firehose-waf-role"]
    }

    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]

    resources = [
      aws_s3_bucket.waf_logs.arn,
      "${aws_s3_bucket.waf_logs.arn}/*"
    ]
  }
}

data "template_file" "waf_s3_secure_transport" {
  template = file("template/s3-secure-transport.json.tpl")

  vars = {
    resource = "${aws_s3_bucket.waf_logs.arn}"
  }
}

## NFW logging bucket

resource "aws_s3_bucket" "nfw_logs" {
  bucket = "s3-ue2-shd-nfw-logs"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-nfw-logs"
  }
}

resource "aws_s3_bucket_public_access_block" "nfw_logs" {
  bucket = aws_s3_bucket.nfw_logs.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "nfw_logs" {
  bucket = aws_s3_bucket.nfw_logs.bucket

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "nfw_logs_s3_policy" {
  bucket = aws_s3_bucket.nfw_logs.id
  policy = data.aws_iam_policy_document.nfw_policy.json
}

data "aws_iam_policy_document" "nfw_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.nfw_logs_allow_access_from_another_account.json,
    data.template_file.nfw_s3_secure_transport.rendered
  ]
}

data "aws_iam_policy_document" "nfw_logs_allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::351894368755:role/firehose-nfw-role"]
    }

    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]

    resources = [
      aws_s3_bucket.nfw_logs.arn,
      "${aws_s3_bucket.nfw_logs.arn}/*"
    ]
  }
}

data "template_file" "nfw_s3_secure_transport" {
  template = file("template/s3-secure-transport.json.tpl")

  vars = {
    resource = "${aws_s3_bucket.nfw_logs.arn}"
  }
}

