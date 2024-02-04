resource "aws_cloudfront_distribution" "homepage_prd" {
  origin {
    domain_name = "s3-ue2-prd-naemo-fe-homepage.s3.amazonaws.com"

    origin_id   = "s3origin"
    
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.homepage_prd.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "BithumbMeta Homepage"
  default_root_object = "index.html"
  price_class = "PriceClass_All"

  logging_config {
    include_cookies = false
    bucket          = "s3-an2-shd-cfnt-logs.s3.amazonaws.com"
    prefix          = "prd"
  }

  # aliases = ["bithumbmeta.io", "www.bithumbmeta.io", "bithumbmeta.co.kr", "bithumbmeta.kr", "bithumbmeta.net", "bithumbmeta.org", "bithumbmeta.xyz"]
  aliases = ["bithumbmeta.io", "www.bithumbmeta.io"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "s3origin"

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  web_acl_id = "arn:aws:wafv2:us-east-1:351894368755:global/webacl/fe_prod_homepage/c10f17b4-50ac-4e2c-aadd-359aa559492e"

  tags = {
    Environment = "cfnt-${var.aws_shot_region}-${var.environment}-homepage",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = aws_acm_certificate.cert_virginia_homepage_temp.arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }
}

resource "aws_cloudfront_origin_access_identity" "homepage_prd" {
  comment = "homepage_prd"
}