resource "aws_s3_bucket" "bucket" {
  bucket = var.name

  tags = {
    Name = var.name
  }  
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "server_side_encryption_configuration" {
  bucket = aws_s3_bucket.bucket.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  	  sse_algorithm = "AES256"
  	}
  }
}