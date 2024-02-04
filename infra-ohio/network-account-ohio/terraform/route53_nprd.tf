## nprd
resource "aws_route53_zone" "nprd_public_domain" {
  name = var.nprd_public_domain
}

# cloudfront - nprd virginia
resource "aws_acm_certificate" "cert_virginia_nprd" {
  provider = aws.virginia
  domain_name       = "${var.nprd_public_domain}"
  subject_alternative_names = ["*.${var.nprd_public_domain}"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "acm-${var.aws_shot_region}-${var.environment}-nprd.naemo.io",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route53_record" "domain_virginia_nprd" {
  for_each = {
    for dvo in aws_acm_certificate.cert_virginia_nprd.domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.nprd_public_domain.zone_id
}

resource "aws_acm_certificate_validation" "domain_virginia_nprd" {
  provider = aws.virginia
  certificate_arn         = aws_acm_certificate.cert_virginia_nprd.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_virginia_nprd : record.fqdn]
}

# alb - nprd ohio
resource "aws_acm_certificate" "cert_nprd" {
  domain_name       = "*.${var.nprd_public_domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "acm-${var.aws_shot_region}-${var.environment}-nprd.naemo.io",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route53_record" "domain_nprd" {
  for_each = {
    for dvo in aws_acm_certificate.cert_nprd.domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.nprd_public_domain.zone_id
}

resource "aws_acm_certificate_validation" "domain_nprd" {
  certificate_arn         = aws_acm_certificate.cert_nprd.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_nprd : record.fqdn]
}