# dev new
# resource "aws_route53_zone" "dev_new_public_domain" {
#   name = var.dev_new_public_domain
#   provider = aws.virginia
# }

# acm 자동 인증 
# 단 새롭게 생성되는 route53 도메인에 ns 정보가 root 도메인에 입력되어야 아래 과정이 수행 되기때문에 
# 수동 작업 선행 되어야 함 
#  new.naemo.io 의 ns 정보 >> naemo.io 
# resource "aws_acm_certificate" "cert_virginia_dev_new" {
#   provider = aws.virginia
#   domain_name       = "${var.dev_new_public_domain}"
#   subject_alternative_names = ["*.${var.dev_new_public_domain}"]
#   validation_method = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }

#   tags = {
#     Name = "acm-${var.aws_shot_region}-${var.environment}-dev-new.naemo.io",
#     System                      = "network",
#     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
#     SupportPlatformOwnerPrimary = "BithumMeta",
#     OperationLevel              = "1"
#   }
# }

# resource "aws_route53_record" "domain_virginia_dev_new" {
#   for_each = {
#     for dvo in aws_acm_certificate.cert_virginia_dev_new.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = aws_route53_zone.dev_new_public_domain.zone_id
#   provider = aws.virginia
# }

# resource "aws_acm_certificate_validation" "domain_virginia_dev_new" {
#   provider = aws.virginia
#   certificate_arn         = aws_acm_certificate.cert_virginia_dev_new.arn
#   validation_record_fqdns = [for record in aws_route53_record.domain_virginia_dev_new : record.fqdn]
# }

# resource "aws_route53_record" "recode_creator-new" {
#   zone_id         = aws_route53_zone.dev_new_public_domain.zone_id
#   name            = "creator.dev-new.naemo.io"
#   type            = "CNAME"
#   ttl             = 60
#   records         = [aws_cloudfront_distribution.creatoradmin_dev_new.domain_name]
#   provider = aws.virginia
# }

# resource "aws_route53_record" "recode_marketplace-new" {
#   zone_id         = aws_route53_zone.dev_new_public_domain.zone_id
#   name            = "dev-new.naemo.io"
#   type            = "CNAME"
#   ttl             = 60
#   records         = [aws_cloudfront_distribution.marketplace_dev_new.domain_name]
#   provider = aws.virginia
#   depends_on = [
#     aws_cloudfront_distribution.marketplace_dev_new
#   ]
# }

# ## dev-bc
resource "aws_route53_zone" "dev_bc_public_domain" {
  name = var.dev_bc_public_domain
  provider = aws.virginia
}


resource "aws_acm_certificate" "cert_virginia_dev_bc" {
  provider = aws.virginia
  domain_name       = "${var.dev_bc_public_domain}"
  subject_alternative_names = ["*.${var.dev_bc_public_domain}"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "acm-${var.aws_shot_region}-${var.environment}-dev-bc.naemo.io",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route53_record" "domain_virginia_dev_bc" {
  for_each = {
    for dvo in aws_acm_certificate.cert_virginia_dev_bc.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.dev_bc_public_domain.zone_id
  provider = aws.virginia
}

resource "aws_acm_certificate_validation" "domain_virginia_dev_bc" {
  provider = aws.virginia
  certificate_arn         = aws_acm_certificate.cert_virginia_dev_bc.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_virginia_dev_bc : record.fqdn]
}

resource "aws_route53_record" "recode_creator-bc" {
  zone_id         = aws_route53_zone.dev_bc_public_domain.zone_id
  name            = "creator.dev-bc.naemo.io"
  type            = "CNAME"
  ttl             = 60
  records         = [aws_cloudfront_distribution.creatoradmin_dev_bc.domain_name]
  provider = aws.virginia
}


