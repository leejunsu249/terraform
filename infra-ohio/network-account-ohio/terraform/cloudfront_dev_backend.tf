resource "aws_cloudfront_distribution" "backend_dev" {
  origin {
    domain_name = "alb-ue2-net-dev-service-320174670.us-east-2.elb.amazonaws.com"
    origin_id   = "alb-ue2-net-dev-service-320174670.us-east-2.elb.amazonaws.com"

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols = ["TLSv1.2"]
      origin_read_timeout = 60
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Backend (dev)"
  default_root_object = "/"
  price_class = "PriceClass_All"

  logging_config {
    include_cookies = false
    bucket          = "s3-an2-shd-cfnt-logs.s3.amazonaws.com"
    prefix          = "dev"
  }

  aliases = ["marketplace.dev.naemo.io", "launchpadruntime.dev.naemo.io", "metaverse.dev.naemo.io", "noti.dev.naemo.io",
            "marketplace-next.dev.naemo.io", "launchpadruntime-next.dev.naemo.io", "metaverse-next.dev.naemo.io", "noti-next.dev.naemo.io"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "alb-ue2-net-dev-service-320174670.us-east-2.elb.amazonaws.com"

    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    compress               = true
    viewer_protocol_policy = "https-only"
    cache_policy_id = aws_cloudfront_cache_policy.backend_cache_policy.id

    # lambda_function_association {
    #   event_type   = "viewer-request"
    #   lambda_arn   = "arn:aws:lambda:us-east-1:351894368755:function:user-queue-request:145"
    #   include_body = true
    # }

    # lambda_function_association {
    #   event_type   = "viewer-response"
    #   lambda_arn   = "arn:aws:lambda:us-east-1:351894368755:function:user-queue-response:1"
    # }
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
    acm_certificate_arn = aws_acm_certificate.cert_virginia_dev.arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }

}