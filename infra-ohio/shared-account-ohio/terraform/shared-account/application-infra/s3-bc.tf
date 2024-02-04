resource "aws_s3_bucket" "gitlab_bc_cache" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-gitlab-bc-cache"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-gitlab-bc-cache"
  }  
}

resource "aws_s3_bucket_public_access_block" "gitlab_bc_cache" {
  bucket = aws_s3_bucket.gitlab_bc_cache.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "gitlab_bc_cache" {
  bucket = aws_s3_bucket.gitlab_bc_cache.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_policy" "gitlab_bc_cache_s3_policy" {
  bucket = aws_s3_bucket.gitlab_bc_cache.id
  policy = data.template_file.gitlab_bc_cache_s3_secure_transport.rendered
}

data "template_file" "gitlab_bc_cache_s3_secure_transport" {
  template = "${file("template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.gitlab_bc_cache.arn}"
  }
}

resource "aws_s3_bucket" "gitlab_bc_artifact" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-gitlab-bc-artifact"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-gitlab-bc-artifact"
  }  
}

resource "aws_s3_bucket_public_access_block" "gitlab_bc_artifact" {
  bucket = aws_s3_bucket.gitlab_bc_artifact.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "gitlab_bc_artifact" {
  bucket = aws_s3_bucket.gitlab_bc_artifact.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_policy" "gitlab_bc_artifact_s3_policy" {
  bucket = aws_s3_bucket.gitlab_bc_artifact.id
  policy = data.template_file.gitlab_bc_artifact_s3_secure_transport.rendered
}

data "template_file" "gitlab_bc_artifact_s3_secure_transport" {
  template = "${file("template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.gitlab_bc_artifact.arn}"
  }
}

resource "aws_s3_bucket" "gitlab_bc_backup" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-gitlab-bc-backup"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-gitlab-bc-backup"
  }  
}

resource "aws_s3_bucket_public_access_block" "gitlab_bc_backup" {
  bucket = aws_s3_bucket.gitlab_bc_backup.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "gitlab_bc_backup" {
  bucket = aws_s3_bucket.gitlab_bc_backup.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_policy" "gitlab_bc_backup_s3_policy" {
  bucket = aws_s3_bucket.gitlab_bc_backup.id
  policy = data.template_file.gitlab_bc_backup_s3_secure_transport.rendered
}

data "template_file" "gitlab_bc_backup_s3_secure_transport" {
  template = "${file("template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.gitlab_bc_backup.arn}"
  }
}
