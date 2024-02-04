resource "aws_cloudfront_distribution" "marketplace_dev_imageresize" {
  origin {
    domain_name = "s3-ue2-dev-naemo-nft.s3.amazonaws.com"
    origin_id   = "s3origin-nft"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.marketplace_dev_next.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Image Resize Test"
  default_root_object = "index.html"
  price_class = "PriceClass_All"

  logging_config {
    include_cookies = false
    bucket          = "s3-an2-shd-cfnt-logs.s3.amazonaws.com"
    prefix          = "image-resize"
  }

  aliases = ["image.naemo.io"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "s3origin-nft"

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/nft/*"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3origin-nft"

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "https-only"
    cache_policy_id        = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  web_acl_id = aws_wafv2_web_acl.fe_non_prod_web_acl.arn

  tags = {
    Environment = "cfnt-${var.aws_shot_region}-${var.environment}-image-resize",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = aws_acm_certificate.cert_virginia_prd.arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }

  lifecycle {
    ignore_changes = [default_cache_behavior[0].lambda_function_association, ordered_cache_behavior[0].lambda_function_association, ordered_cache_behavior[0].cache_policy_id]
  }
}

resource "aws_cloudfront_origin_access_identity" "marketplace_dev_imageresize" {
  comment = "marketplace_dev_imageresize"
}