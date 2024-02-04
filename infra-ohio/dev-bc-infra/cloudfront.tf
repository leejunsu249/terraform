data "aws_cloudfront_cache_policy" "index_page_policy" {
  id = "d5be2d59-6938-44af-ab89-a3300cacf5ee"
  provider = aws.ohio
}

data "aws_cloudfront_cache_policy" "backadn_policy" {
  id = "cc3a7ee4-2c58-49fe-9444-264079705f51"
  provider = aws.ohio
}


### cloudfront bc 

resource "aws_cloudfront_distribution" "marketplace_dev_bc" {
  origin {
    domain_name = "s3-ue2-dev-naemo-fe-marketplace-bc.s3.amazonaws.com"
    origin_id   = "s3origin"
    
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.marketplace_dev_bc.cloudfront_access_identity_path
    }
  }

  origin {
    domain_name = "s3-ue2-dev-naemo-launchpad-bc.s3.amazonaws.com"
    origin_id   = "s3origin-launchpad"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.marketplace_dev_bc.cloudfront_access_identity_path
    }
  }
  
  origin {
    domain_name = "s3-ue2-dev-naemo-collection-bc.s3.amazonaws.com"
    origin_id   = "s3origin-collection"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.marketplace_dev_bc.cloudfront_access_identity_path
    }
  }

  origin {
    domain_name = "s3-ue2-dev-naemo-member-bc.s3.amazonaws.com"
    origin_id   = "s3origin-member"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.marketplace_dev_bc.cloudfront_access_identity_path
    }
  }

  origin {
    domain_name = "s3-ue2-dev-naemo-nft-bc.s3.amazonaws.com"
    origin_id   = "s3origin-nft"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.marketplace_dev_bc.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Marketplace Frontend(dev-bc)"
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
    prefix          = "dev-bc"
  }

  aliases = ["dev-bc.naemo.io"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "s3origin"

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = data.aws_cloudfront_cache_policy.index_page_policy.id

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
    cache_policy_id        = data.aws_cloudfront_cache_policy.index_page_policy.id

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

  web_acl_id = "arn:aws:wafv2:us-east-1:351894368755:global/webacl/fe_non_prod_web_acl/e092ebff-6d86-4296-a88c-b7601f5a0507"

  tags = {
    Environment = "cfnt-${var.aws_shot_region}-${var.environment}-marketplace-bc",
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = aws_acm_certificate.cert_virginia_dev_bc.arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }
   provider = aws.ohio

}

resource "aws_cloudfront_origin_access_identity" "marketplace_dev_bc" {
  comment = "marketplace_dev_bc"
  provider = aws.ohio
}


#### creator cloudfront 

resource "aws_cloudfront_distribution" "creatoradmin_dev_bc" {
  origin {
    domain_name = "s3-ue2-dev-naemo-fe-creator-bc.s3.amazonaws.com"
    origin_id   = "s3origin"
    
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.creatoradmin_dev_bc.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Creator Admin Frontend(dev-bc)"
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
    prefix          = "dev"
  }

  aliases = ["creator.dev-bc.naemo.io"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "s3origin"

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = data.aws_cloudfront_cache_policy.index_page_policy.id

    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = "arn:aws:lambda:us-east-1:351894368755:function:403-rewrite-request:5"
      include_body = false
    }
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

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/index.html"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3origin"

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = data.aws_cloudfront_cache_policy.index_page_policy.id

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

  web_acl_id = "arn:aws:wafv2:us-east-1:351894368755:global/webacl/fe_non_prod_web_acl/e092ebff-6d86-4296-a88c-b7601f5a0507"

  tags = {
    Environment = "cfnt-${var.aws_shot_region}-${var.environment}-creatoradmin-bc",
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = aws_acm_certificate.cert_virginia_dev_bc.arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }
  provider = aws.ohio
}

resource "aws_cloudfront_origin_access_identity" "creatoradmin_dev_bc" {
  comment = "creatoradmin_dev_bc"
  provider = aws.ohio
}

## backend bc 

# resource "aws_cloudfront_distribution" "backend_dev-bc" {
#   origin {
#     domain_name = "alb-ue2-net-dev-service-320174670.us-east-2.elb.amazonaws.com"
#     origin_id   = "alb-ue2-net-dev-service-320174670.us-east-2.elb.amazonaws.com"

#     custom_origin_config {
#       http_port = 80
#       https_port = 443
#       origin_protocol_policy = "https-only"
#       origin_ssl_protocols = ["TLSv1.2"]
#       origin_read_timeout = 60
#     }
#   }

#   enabled             = true
#   is_ipv6_enabled     = true
#   comment             = "Backend (dev-bc)"
#   default_root_object = "/"
#   price_class = "PriceClass_All"

#   logging_config {
#     include_cookies = false
#     bucket          = "s3-an2-shd-cfnt-logs.s3.amazonaws.com"
#     prefix          = "dev"
#   }

#   aliases = ["marketplace.dev-bc.naemo.io", "launchpadruntime.dev-bc.naemo.io", "metaverse.dev-bc.naemo.io", "noti.dev-bc.naemo.io"]

#   default_cache_behavior {
#     allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#     cached_methods   = ["GET", "HEAD", "OPTIONS"]
#     target_origin_id = "alb-ue2-net-dev-service-320174670.us-east-2.elb.amazonaws.com"

#     origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
#     compress               = true
#     viewer_protocol_policy = "https-only"
#     cache_policy_id = data.aws_cloudfront_cache_policy.backadn_policy.id

#     # lambda_function_association {
#     #   event_type   = "viewer-request"
#     #   lambda_arn   = "arn:aws:lambda:us-east-1:351894368755:function:user-queue-request:145"
#     #   include_body = true
#     # }

#     # lambda_function_association {
#     #   event_type   = "viewer-response"
#     #   lambda_arn   = "arn:aws:lambda:us-east-1:351894368755:function:user-queue-response:1"
#     # }
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   web_acl_id = "arn:aws:wafv2:us-east-1:351894368755:global/webacl/fe_non_prod_web_acl/e092ebff-6d86-4296-a88c-b7601f5a0507"

#   tags = {
#     Environment = "cfnt-${var.aws_shot_region}-${var.environment}-backend-bc",
#     System                      = "network",
#     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
#     SupportPlatformOwnerPrimary = "BithumMeta",
#     OperationLevel              = "1"
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = false
#     acm_certificate_arn = aws_acm_certificate.cert_virginia_dev_bc.arn
#     ssl_support_method = "sni-only"
#     minimum_protocol_version = "TLSv1.2_2019"

#   }
#    provider = aws.ohio


# }


##########################

### cloudfront new 

# resource "aws_cloudfront_distribution" "marketplace_dev_new" {
#   origin {
#     domain_name = "s3-ue2-dev-naemo-fe-marketplace-new.s3.amazonaws.com"
#     origin_id   = "s3origin"
    
#     s3_origin_config {
#       origin_access_identity = aws_cloudfront_origin_access_identity.marketplace_dev_new.cloudfront_access_identity_path
#     }
#   }

#   origin {
#     domain_name = "s3-ue2-dev-naemo-launchpad-new.s3.amazonaws.com"
#     origin_id   = "s3origin-launchpad"

#     s3_origin_config {
#       origin_access_identity = aws_cloudfront_origin_access_identity.marketplace_dev_new.cloudfront_access_identity_path
#     }
#   }
  
#   origin {
#     domain_name = "s3-ue2-dev-naemo-collection-new.s3.amazonaws.com"
#     origin_id   = "s3origin-collection"

#     s3_origin_config {
#       origin_access_identity = aws_cloudfront_origin_access_identity.marketplace_dev_new.cloudfront_access_identity_path
#     }
#   }

#   origin {
#     domain_name = "s3-ue2-dev-naemo-member-new.s3.amazonaws.com"
#     origin_id   = "s3origin-member"

#     s3_origin_config {
#       origin_access_identity = aws_cloudfront_origin_access_identity.marketplace_dev_new.cloudfront_access_identity_path
#     }
#   }

#   origin {
#     domain_name = "s3-ue2-dev-naemo-nft-new.s3.amazonaws.com"
#     origin_id   = "s3origin-nft"

#     s3_origin_config {
#       origin_access_identity = aws_cloudfront_origin_access_identity.marketplace_dev_new.cloudfront_access_identity_path
#     }
#   }

#   enabled             = true
#   is_ipv6_enabled     = true
#   comment             = "Marketplace Frontend(dev-new)"
#   default_root_object = "index.html"
#   price_class = "PriceClass_All"

#   custom_error_response {
#     error_code = "403"
#     response_code = "200"
#     response_page_path = "/index.html"
#   }
  
#   custom_error_response {
#     error_code = "404"
#     response_code = "200"
#     response_page_path = "/index.html"
#   }

#   logging_config {
#     include_cookies = false
#     bucket          = "s3-an2-shd-cfnt-logs.s3.amazonaws.com"
#     prefix          = "dev-new"
#   }

#   aliases = ["dev-new.naemo.io"]

#   default_cache_behavior {
#     allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#     cached_methods   = ["GET", "HEAD", "OPTIONS"]
#     target_origin_id = "s3origin"

#     min_ttl                = 0
#     default_ttl            = 0
#     max_ttl                = 0
#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#     cache_policy_id        = data.aws_cloudfront_cache_policy.index_page_policy.id

#     lambda_function_association {
#       event_type   = "viewer-request"
#       lambda_arn   = "arn:aws:lambda:us-east-1:351894368755:function:403-rewrite-request:5"
#       include_body = false
#     }
#   }

#   # Cache behavior with precedence 0
#   ordered_cache_behavior {
#     path_pattern     = "/nft/*"
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "s3origin-nft"

#     min_ttl                = 0
#     default_ttl            = 0
#     max_ttl                = 0
#     compress               = true
#     viewer_protocol_policy = "https-only"
#     cache_policy_id = "f807cd55-9caf-47d6-b06c-4dee6def91ee"

#     lambda_function_association {
#       event_type   = "origin-request"
#       lambda_arn   = "arn:aws:lambda:us-east-1:351894368755:function:labmda_edge_resizing_origin_request:9"
#       include_body = false
#     }    
#   }

#   # Cache behavior with precedence 1
#   ordered_cache_behavior {
#     path_pattern     = "/launchpad/*"
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "s3origin-launchpad"

#     min_ttl                = 0
#     default_ttl            = 0
#     max_ttl                = 0
#     compress               = true
#     viewer_protocol_policy = "https-only"
#     cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
#   }

#   # Cache behavior with precedence 2
#   ordered_cache_behavior {
#     path_pattern     = "/collection/*"
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "s3origin-collection"

#     min_ttl                = 0
#     default_ttl            = 0
#     max_ttl                = 0
#     compress               = true
#     viewer_protocol_policy = "https-only"
#     cache_policy_id = "f807cd55-9caf-47d6-b06c-4dee6def91ee"

#     lambda_function_association {
#       event_type   = "origin-request"
#       lambda_arn   = "arn:aws:lambda:us-east-1:351894368755:function:labmda_edge_resizing_origin_request:9"
#       include_body = false
#     }        
#   }

#   # Cache behavior with precedence 
#   ordered_cache_behavior {
#     path_pattern     = "/member/*"
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "s3origin-member"

#     min_ttl                = 0
#     default_ttl            = 0
#     max_ttl                = 0
#     compress               = true
#     viewer_protocol_policy = "https-only"
#     cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
#   }

#   # Cache behavior with precedence 
#   ordered_cache_behavior {
#     path_pattern     = "/static/*"
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "s3origin"

#     min_ttl                = 0
#     default_ttl            = 0
#     max_ttl                = 0
#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#     cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
#   }

#  # Cache behavior with precedence 
#   ordered_cache_behavior {
#     path_pattern     = "/images/*"
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "s3origin"

#     min_ttl                = 0
#     default_ttl            = 0
#     max_ttl                = 0
#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#     cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
#   }

#   # Cache behavior with precedence 
#   ordered_cache_behavior {
#     path_pattern     = "index.html"
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "s3origin"

#     min_ttl                = 0
#     default_ttl            = 0
#     max_ttl                = 0
#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#     cache_policy_id        = data.aws_cloudfront_cache_policy.index_page_policy.id

#     lambda_function_association {
#       event_type   = "viewer-request"
#       lambda_arn   = "arn:aws:lambda:us-east-1:351894368755:function:403-rewrite-request:5"
#       include_body = false
#     }
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   web_acl_id = "arn:aws:wafv2:us-east-1:351894368755:global/webacl/fe_non_prod_web_acl/e092ebff-6d86-4296-a88c-b7601f5a0507"

#   tags = {
#     Environment = "cfnt-${var.aws_shot_region}-${var.environment}-marketplace-new",
#     System                      = "marketplace",
#     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
#     SupportPlatformOwnerPrimary = "BithumMeta",
#     OperationLevel              = "2"
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = false
#     acm_certificate_arn = aws_acm_certificate.cert_virginia_dev_new.arn
#     ssl_support_method = "sni-only"
#     minimum_protocol_version = "TLSv1.2_2019"
#   }
#    provider = aws.ohio

# }

# resource "aws_cloudfront_origin_access_identity" "marketplace_dev_new" {
#   comment = "marketplace_dev_new"
#   provider = aws.ohio
# }


# #### creator cloudfront 

# resource "aws_cloudfront_distribution" "creatoradmin_dev_new" {
#   origin {
#     domain_name = "s3-ue2-dev-naemo-fe-creator-new.s3.amazonaws.com"
#     origin_id   = "s3origin"
    
#     s3_origin_config {
#       origin_access_identity = aws_cloudfront_origin_access_identity.creatoradmin_dev_new.cloudfront_access_identity_path
#     }
#   }

#   enabled             = true
#   is_ipv6_enabled     = true
#   comment             = "Creator Admin Frontend(dev-new)"
#   default_root_object = "index.html"
#   price_class = "PriceClass_All"

#   custom_error_response {
#     error_code = "403"
#     response_code = "200"
#     response_page_path = "/index.html"
#   }
  
#   custom_error_response {
#     error_code = "404"
#     response_code = "200"
#     response_page_path = "/index.html"
#   }

#   logging_config {
#     include_cookies = false
#     bucket          = "s3-an2-shd-cfnt-logs.s3.amazonaws.com"
#     prefix          = "dev"
#   }

#   aliases = ["creator.dev-new.naemo.io"]

#   default_cache_behavior {
#     allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#     cached_methods   = ["GET", "HEAD", "OPTIONS"]
#     target_origin_id = "s3origin"

#     min_ttl                = 0
#     default_ttl            = 0
#     max_ttl                = 0
#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#     cache_policy_id        = data.aws_cloudfront_cache_policy.index_page_policy.id

#     lambda_function_association {
#       event_type   = "viewer-request"
#       lambda_arn   = "arn:aws:lambda:us-east-1:351894368755:function:403-rewrite-request:5"
#       include_body = false
#     }
#   }

#   # Cache behavior with precedence 
#   ordered_cache_behavior {
#     path_pattern     = "/static/*"
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "s3origin"

#     min_ttl                = 0
#     default_ttl            = 0
#     max_ttl                = 0
#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#     cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
#   }

#  # Cache behavior with precedence 
#   ordered_cache_behavior {
#     path_pattern     = "/images/*"
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "s3origin"

#     min_ttl                = 0
#     default_ttl            = 0
#     max_ttl                = 0
#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#     cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
#   }

#   # Cache behavior with precedence 0
#   ordered_cache_behavior {
#     path_pattern     = "/index.html"
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "s3origin"

#     min_ttl                = 0
#     default_ttl            = 0
#     max_ttl                = 0
#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#     cache_policy_id        = data.aws_cloudfront_cache_policy.index_page_policy.id

#     lambda_function_association {
#       event_type   = "viewer-request"
#       lambda_arn   = "arn:aws:lambda:us-east-1:351894368755:function:403-rewrite-request:5"
#       include_body = false
#     }    
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   web_acl_id = "arn:aws:wafv2:us-east-1:351894368755:global/webacl/fe_non_prod_web_acl/e092ebff-6d86-4296-a88c-b7601f5a0507"

#   tags = {
#     Environment = "cfnt-${var.aws_shot_region}-${var.environment}-creatoradmin-new",
#     System                      = "marketplace",
#     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
#     SupportPlatformOwnerPrimary = "BithumMeta",
#     OperationLevel              = "2"
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = false
#     acm_certificate_arn = aws_acm_certificate.cert_virginia_dev_new.arn
#     ssl_support_method = "sni-only"
#     minimum_protocol_version = "TLSv1.2_2019"
#   }
#   provider = aws.ohio
# }

# resource "aws_cloudfront_origin_access_identity" "creatoradmin_dev_new" {
#   comment = "creatoradmin_dev_new"
#   provider = aws.ohio
# }

