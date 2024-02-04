locals {
  cloudfront_oai = var.environment == "dev" ? ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.cloudfront_marketplace_oai}",
      "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.cloudfront_marketplace_next_oai}",
      "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E3Q4M72LFZ01KM"] : ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.cloudfront_marketplace_oai}"]
}
