resource "aws_route53_zone" "homepage_domain" {
  name = var.homepage_domain
}

resource "aws_route53_zone" "homepage_domain_cokr" {
  name = var.homepage_domain_cokr
}

resource "aws_route53_zone" "homepage_domain_kr" {
  name = var.homepage_domain_kr
}

resource "aws_route53_zone" "homepage_domain_net" {
  name = var.homepage_domain_net
}

resource "aws_route53_zone" "homepage_domain_org" {
  name = var.homepage_domain_org
}

resource "aws_route53_zone" "homepage_domain_xyz" {
  name = var.homepage_domain_xyz
}

# # cloudfront - homepage
# resource "aws_acm_certificate" "cert_virginia_homepage" {
#   provider = aws.virginia
#   domain_name       = "${var.homepage_domain}"
#   subject_alternative_names = ["*.${var.homepage_domain}", "${var.homepage_domain_kr}", "${var.homepage_domain_net}", "${var.homepage_domain_org}", "${var.homepage_domain_xyz}", "${var.homepage_domain_cokr}"]
#   validation_method = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }

#   tags = {
#     Name = "acm-${var.aws_shot_region}-${var.environment}-bithumbmeta"
#   }
# }

# resource "aws_route53_record" "domain_virginia_homepage" {
#   for_each = {
#     for dvo in aws_acm_certificate.cert_virginia_homepage.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     } if dvo.domain_name == var.homepage_domain
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = aws_route53_zone.homepage_domain.zone_id
# }

# resource "aws_acm_certificate_validation" "cert_virginia_homepage" {
#   provider = aws.virginia
#   certificate_arn         = aws_acm_certificate.cert_virginia_homepage.arn
#   validation_record_fqdns = [for record in aws_route53_record.domain_virginia_homepage : record.fqdn]
# }

# resource "aws_route53_record" "domain_virginia_homepage_cokr" {
#   for_each = {
#     for dvo in aws_acm_certificate.cert_virginia_homepage.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     } if dvo.domain_name == var.homepage_domain_cokr
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = aws_route53_zone.homepage_domain_cokr.zone_id
# }

# resource "aws_acm_certificate_validation" "cert_virginia_homepage_cokr" {
#   provider = aws.virginia
#   certificate_arn         = aws_acm_certificate.cert_virginia_homepage.arn
#   validation_record_fqdns = [for record in aws_route53_record.domain_virginia_homepage_cokr : record.fqdn]
# }

# resource "aws_route53_record" "domain_virginia_homepage_xyz" {
#   for_each = {
#     for dvo in aws_acm_certificate.cert_virginia_homepage.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     } if dvo.domain_name == var.homepage_domain_xyz
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = aws_route53_zone.homepage_domain_xyz.zone_id
# }

# resource "aws_acm_certificate_validation" "cert_virginia_homepage_xyz" {
#   provider = aws.virginia
#   certificate_arn         = aws_acm_certificate.cert_virginia_homepage.arn
#   validation_record_fqdns = [for record in aws_route53_record.domain_virginia_homepage_xyz : record.fqdn]
# }

# resource "aws_route53_record" "domain_virginia_homepage_org" {
#   for_each = {
#     for dvo in aws_acm_certificate.cert_virginia_homepage.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     } if dvo.domain_name == var.homepage_domain_org
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = aws_route53_zone.homepage_domain_org.zone_id
# }

# resource "aws_acm_certificate_validation" "cert_virginia_homepage_org" {
#   provider = aws.virginia
#   certificate_arn         = aws_acm_certificate.cert_virginia_homepage.arn
#   validation_record_fqdns = [for record in aws_route53_record.domain_virginia_homepage_org : record.fqdn]
# }

# resource "aws_route53_record" "domain_virginia_homepage_kr" {
#   for_each = {
#     for dvo in aws_acm_certificate.cert_virginia_homepage.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     } if dvo.domain_name == var.homepage_domain_kr
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = aws_route53_zone.homepage_domain_kr.zone_id
# }

# resource "aws_acm_certificate_validation" "cert_virginia_homepage_kr" {
#   provider = aws.virginia
#   certificate_arn         = aws_acm_certificate.cert_virginia_homepage.arn
#   validation_record_fqdns = [for record in aws_route53_record.domain_virginia_homepage_kr : record.fqdn]
# }


# resource "aws_route53_record" "domain_virginia_homepage_net" {
#   for_each = {
#     for dvo in aws_acm_certificate.cert_virginia_homepage.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     } if dvo.domain_name == var.homepage_domain_net
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = aws_route53_zone.homepage_domain_net.zone_id
# }

# temp
resource "aws_acm_certificate" "cert_virginia_homepage_temp" {
  provider = aws.virginia
  domain_name       = "${var.homepage_domain}"
  subject_alternative_names = ["*.${var.homepage_domain}"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "acm-${var.aws_shot_region}-${var.environment}-bithumbmeta",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_route53_record" "domain_virginia_homepage_temp" {
  for_each = {
    for dvo in aws_acm_certificate.cert_virginia_homepage_temp.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if dvo.domain_name == var.homepage_domain
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.homepage_domain.zone_id
}

resource "aws_acm_certificate_validation" "cert_virginia_homepage_temp" {
  provider = aws.virginia
  certificate_arn         = aws_acm_certificate.cert_virginia_homepage_temp.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_virginia_homepage_temp : record.fqdn]
}