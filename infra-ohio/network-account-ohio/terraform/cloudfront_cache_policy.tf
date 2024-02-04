resource "aws_cloudfront_cache_policy" "index_page_policy" {
  name        = "IndexPagePolicy"
  comment     = "Policy for index.html"
  default_ttl = 600
  max_ttl     = 600
  min_ttl     = 1

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }

    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip   = true
  }
}

resource "aws_cloudfront_cache_policy" "backend_cache_policy" {
  name        = "BackendCachePolicy"
  comment     = "Policy for index.html"
  default_ttl = 0
  max_ttl     = 600
  min_ttl     = 0

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "whitelist"
      headers {
        items = ["x-language-code", "Origin", "Access-Control-Request-Headers"]
      } 
    }
    query_strings_config {
      query_string_behavior = "all"
    }

    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip   = true
  }
}