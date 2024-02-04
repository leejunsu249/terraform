resource "aws_cloudfront_distribution" "backend_nprd" {
  origin {
    domain_name = "alb-ue2-net-nprd-service-381353303.us-east-2.elb.amazonaws.com"
    origin_id   = "alb-ue2-net-nprd-service-381353303.us-east-2.elb.amazonaws.com"

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols = ["TLSv1.2"]
      origin_read_timeout = 90
      origin_keepalive_timeout = 10
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Backend (nprd)"
  default_root_object = "/"
  price_class = "PriceClass_All"

  logging_config {
    include_cookies = false
    bucket          = "s3-an2-shd-cfnt-logs.s3.amazonaws.com"
    prefix          = "nprd"
  }

  aliases = ["marketplace.nprd.naemo.io", "launchpadruntime.nprd.naemo.io", "metaverse.nprd.naemo.io"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "alb-ue2-net-nprd-service-381353303.us-east-2.elb.amazonaws.com"

    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    compress               = true
    viewer_protocol_policy = "https-only"
    cache_policy_id = aws_cloudfront_cache_policy.backend_cache_policy.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  web_acl_id = aws_wafv2_web_acl.fe_non_prod_web_acl.arn

  tags = {
    Environment = "cfnt-${var.aws_shot_region}-${var.environment}-backend",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = aws_acm_certificate.cert_virginia_nprd.arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }

  lifecycle {
    ignore_changes = [default_cache_behavior[0].lambda_function_association]
  }
}