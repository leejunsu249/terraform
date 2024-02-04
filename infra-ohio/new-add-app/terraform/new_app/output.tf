output "holder_verify_s3_domain" {
  value = "${aws_s3_bucket.holder_verify.bucket_regional_domain_name}"
}

