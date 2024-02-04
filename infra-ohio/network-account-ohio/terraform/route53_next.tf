## dev
resource "aws_route53_zone" "dev_next_public_domain" {
  name = var.dev_next_public_domain
}

# cloudfront - dev
resource "aws_acm_certificate" "cert_virginia_dev_next" {
  provider = aws.virginia
  domain_name       = "${var.dev_next_public_domain}"
  subject_alternative_names = ["*.${var.dev_next_public_domain}"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "acm-${var.aws_shot_region}-${var.environment}-dev-next.naemo.io",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route53_record" "domain_virginia_dev_next" {
  for_each = {
    for dvo in aws_acm_certificate.cert_virginia_dev_next.domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.dev_next_public_domain.zone_id
}

resource "aws_acm_certificate_validation" "domain_virginia_dev_next" {
  provider = aws.virginia
  certificate_arn         = aws_acm_certificate.cert_virginia_dev_next.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_virginia_dev_next : record.fqdn]
}
