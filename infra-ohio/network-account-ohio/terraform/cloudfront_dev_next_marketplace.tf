resource "aws_cloudfront_distribution" "marketplace_dev_next" {
  origin {
    domain_name = "s3-ue2-dev-naemo-fe-marketplace-next.s3.amazonaws.com"
    origin_id   = "s3origin"
    
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.marketplace_dev_next.cloudfront_access_identity_path
    }
  }

  origin {
    domain_name = "s3-ue2-dev-naemo-launchpad.s3.amazonaws.com"
    origin_id   = "s3origin-launchpad"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.marketplace_dev_next.cloudfront_access_identity_path
    }
  }
  
  origin {
    domain_name = "s3-ue2-dev-naemo-collection.s3.amazonaws.com"
    origin_id   = "s3origin-collection"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.marketplace_dev_next.cloudfront_access_identity_path
    }
  }

  origin {
    domain_name = "s3-ue2-dev-naemo-member.s3.amazonaws.com"
    origin_id   = "s3origin-member"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.marketplace_dev_next.cloudfront_access_identity_path
    }
  }

  origin {
    domain_name = "s3-ue2-dev-naemo-nft.s3.amazonaws.com"
    origin_id   = "s3origin-nft"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.marketplace_dev_next.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Marketplace Frontend(dev-next)"
  default_root_object = "index.html"
  price_class = "PriceClass_All"

  custom_error_response {
    error_code = "403"
    response_code = "200"
    response_page_path = "/index.html"
  }
  
  custom_error_response {
    error_code = "404"
    response_code = "200"
    response_page_path = "/index.html"
  }

  logging_config {
    include_cookies = false
    bucket          = "s3-an2-shd-cfnt-logs.s3.amazonaws.com"
    prefix          = "dev-next"
  }

  aliases = ["dev-next.naemo.io"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "s3origin"

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = aws_cloudfront_cache_policy.index_page_policy.id

    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = "arn:aws:lambda:us-east-1:351894368755:function:403-rewrite-request:5"
      include_body = false
    }
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
    cache_policy_id = "f807cd55-9caf-47d6-b06c-4dee6def91ee"

    lambda_function_association {
      event_type   = "origin-request"
      lambda_arn   = "arn:aws:lambda:us-east-1:351894368755:function:labmda_edge_resizing_origin_request:9"
      include_body = false
    }    
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/launchpad/*"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3origin-launchpad"

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "https-only"
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

  # Cache behavior with precedence 2
  ordered_cache_behavior {
    path_pattern     = "/collection/*"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3origin-collection"

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "https-only"
    cache_policy_id = "f807cd55-9caf-47d6-b06c-4dee6def91ee"

    lambda_function_association {
      event_type   = "origin-request"
      lambda_arn   = "arn:aws:lambda:us-east-1:351894368755:function:labmda_edge_resizing_origin_request:9"
      include_body = false
    }        
  }

  # Cache behavior with precedence 
  ordered_cache_behavior {
    path_pattern     = "/member/*"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3origin-member"

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "https-only"
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

  # Cache behavior with precedence 
  ordered_cache_behavior {
    path_pattern     = "/static/*"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3origin"

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

 # Cache behavior with precedence 
  ordered_cache_behavior {
    path_pattern     = "/images/*"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3origin"

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

  # Cache behavior with precedence 
  ordered_cache_behavior {
    path_pattern     = "index.html"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3origin"

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = aws_cloudfront_cache_policy.index_page_policy.id

    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = "arn:aws:lambda:us-east-1:351894368755:function:403-rewrite-request:5"
      include_body = false
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  web_acl_id = aws_wafv2_web_acl.fe_non_prod_web_acl.arn

  tags = {
    Environment = "cfnt-${var.aws_shot_region}-${var.environment}-marketplace-next",
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = aws_acm_certificate.cert_virginia_dev_next.arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }

}

resource "aws_cloudfront_origin_access_identity" "marketplace_dev_next" {
  comment = "marketplace_dev_next"
}