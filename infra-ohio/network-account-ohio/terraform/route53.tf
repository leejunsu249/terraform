resource "aws_route53_zone" "domain" {
  name = var.domain

  vpc {
    vpc_id = aws_vpc.ingress.id
  }
  lifecycle { ignore_changes = [vpc] }
}

resource "aws_route53_zone" "public_domain" {
  name = var.public_domain
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "*.${var.public_domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "acm-${var.aws_shot_region}-${var.environment}-naemo.io",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route53_record" "domain" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.public_domain.zone_id
}

resource "aws_acm_certificate_validation" "domain" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.domain : record.fqdn]
}

resource "aws_acm_certificate" "feature_cert" {
  domain_name       = "*.feature.${var.public_domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "acm-${var.aws_shot_region}-${var.environment}-feature.naemo.io",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_acm_certificate" "feature_an2_cert" {
  domain_name       = "*.an2-feature.${var.public_domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "acm-${var.aws_shot_region}-${var.environment}-an2-feature.naemo.io",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

## dev

resource "aws_route53_zone" "dev_public_domain" {
  name = var.dev_public_domain
}

resource "aws_acm_certificate" "cert_dev" {
  domain_name       = "*.${var.dev_public_domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "acm-${var.aws_shot_region}-${var.environment}-dev.naemo.io",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route53_record" "domain_dev" {
  for_each = {
    for dvo in aws_acm_certificate.cert_dev.domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.dev_public_domain.zone_id
}

resource "aws_acm_certificate_validation" "domain_dev" {
  certificate_arn         = aws_acm_certificate.cert_dev.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_dev : record.fqdn]
}

## stg
resource "aws_route53_zone" "stg_public_domain" {
  name = var.stg_public_domain
}

resource "aws_acm_certificate" "cert_stg" {
  domain_name       = "*.${var.stg_public_domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "acm-${var.aws_shot_region}-${var.environment}-stg.naemo.io",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route53_record" "domain_stg" {
  for_each = {
    for dvo in aws_acm_certificate.cert_stg.domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.stg_public_domain.zone_id
}

resource "aws_acm_certificate_validation" "domain_stg" {
  certificate_arn         = aws_acm_certificate.cert_stg.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_stg : record.fqdn]
}

# cloudfront - dev

resource "aws_acm_certificate" "cert_virginia_dev" {
  provider = aws.virginia
  domain_name       = "${var.dev_public_domain}"
  subject_alternative_names = ["*.${var.dev_public_domain}"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "acm-${var.aws_shot_region}-${var.environment}-dev.naemo.io",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route53_record" "domain_virginia_dev" {
  for_each = {
    for dvo in aws_acm_certificate.cert_virginia_dev.domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.dev_public_domain.zone_id
}

resource "aws_acm_certificate_validation" "domain_virginia_dev" {
  provider = aws.virginia
  certificate_arn         = aws_acm_certificate.cert_virginia_dev.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_virginia_dev : record.fqdn]
}

# cloudfront - stg

resource "aws_acm_certificate" "cert_virginia_stg" {
  provider = aws.virginia
  domain_name       = "${var.stg_public_domain}"
  subject_alternative_names = ["*.${var.stg_public_domain}"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "acm-${var.aws_shot_region}-${var.environment}-stg.naemo.io",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route53_record" "domain_virginia_stg" {
  for_each = {
    for dvo in aws_acm_certificate.cert_virginia_stg.domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.stg_public_domain.zone_id
}

resource "aws_acm_certificate_validation" "domain_virginia_stg" {
  provider = aws.virginia
  certificate_arn         = aws_acm_certificate.cert_virginia_stg.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_virginia_stg : record.fqdn]
}

# cloudfront - prd

resource "aws_acm_certificate" "cert_virginia_prd" {
  provider = aws.virginia
  domain_name       = "${var.public_domain}"
  subject_alternative_names = ["*.${var.public_domain}"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "acm-${var.aws_shot_region}-${var.environment}-naemo.io",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route53_record" "domain_virginia_prd" {
  for_each = {
    for dvo in aws_acm_certificate.cert_virginia_prd.domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.public_domain.zone_id
}

resource "aws_acm_certificate_validation" "domain_virginia_prd" {
  provider = aws.virginia
  certificate_arn         = aws_acm_certificate.cert_virginia_prd.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_virginia_prd : record.fqdn]
}
