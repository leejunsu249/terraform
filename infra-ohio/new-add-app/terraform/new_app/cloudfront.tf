# data "aws_cloudfront_cache_policy" "index_page_policy" {
#   id = "d5be2d59-6938-44af-ab89-a3300cacf5ee"
#   provider = aws.net_ohio
# }

# resource "aws_cloudfront_distribution" "holder-verify" {
#   origin {
#     domain_name = aws_s3_bucket.holder-verify.bucket_domain_name
#     origin_id   = "s3origin"
    
#     s3_origin_config {
#       origin_access_identity = aws_cloudfront_origin_access_identity.holder-verify_origin_id.cloudfront_access_identity_path
#   }

#   enabled             = true
#   is_ipv6_enabled     = true
#   comment             = "Holder-Verify Frontend(dev)"
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

#   aliases = ["holder-verify.dev.naemo.io"]

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
# }
# provider = aws.net_ohio
# }
# resource "aws_cloudfront_origin_access_identity" "holder-verify_origin_id" {
#   comment = "discord_origin"
#   provider = aws.net_ohio
#   depends_on = [
#     aws_cloudfront_distribution.holder-verify
#   ]
# }

# # zone_id 변수 처리 해야함
# resource "aws_route53_record" "recode_creator-bc" {
#   zone_id         = ""
#   name            = "holder-verify-next.dev.naemo.io"
#   type            = "CNAME"
#   ttl             = 60
#   records         = [aws_cloudfront_distribution.holder-verify.domain_name]
#   provider = aws.net_viz
#   depends_on = [
#     aws_cloudfront_distribution.holder-verify
#   ]
# }