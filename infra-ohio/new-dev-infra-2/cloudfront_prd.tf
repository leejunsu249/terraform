resource "aws_cloudfront_distribution" "holder-verify-prd" {
  # provider = aws.net_ohio
  origin {
    domain_name = data.terraform_remote_state.prd_s3.outputs.holder_verify_s3_domain # TODO
    origin_id   = "s3origin"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.holder-verify-prd_origin_id.cloudfront_access_identity_path
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
 
  web_acl_id = "arn:aws:wafv2:us-east-1:351894368755:global/webacl/fe_prod_web_acl/265be880-3e63-4c59-a2e9-be6f38b2fd7e"

  # Certification Settings 
  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = "arn:aws:acm:us-east-1:351894368755:certificate/7819a17f-f4de-4755-9863-1b7a531a8da4"
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }
  
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Holder-Verify Frontend(prd)"
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
    prefix          = "prd"
  }

  aliases = ["holder-verify.naemo.io"]

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
}

resource "aws_cloudfront_origin_access_identity" "holder-verify-prd_origin_id" {
  comment = "holder_origin_prd"
}

resource "aws_route53_record" "holder_verify_prd" {
  zone_id         = "Z01822853RGEKRPKOXI3R" #TODO 변경
  name            = "holder-verify.naemo.io" #TODO  변경
  type            = "CNAME"
  ttl             = 60
  records         = [aws_cloudfront_distribution.holder-verify-prd.domain_name]
  depends_on = [
    aws_cloudfront_distribution.holder-verify-prd
  ]
}