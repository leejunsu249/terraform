resource "aws_route53_zone" "domain" {
  name = var.domain

  lifecycle { ignore_changes = [vpc] }

  vpc {
    vpc_id = aws_vpc.vpc.id
  }

  tags = {
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_route53_zone" "feature_domain" {
  count = var.environment == "dev" ? 1 : 0

  name = var.feature_domain

  vpc {
    vpc_id = aws_vpc.vpc.id
  }

  lifecycle { ignore_changes = [vpc] }

  tags = {
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

##### wallet #####

resource "aws_route53_zone_association" "domain" {
  zone_id = aws_route53_zone.domain.zone_id
  vpc_id  = aws_vpc.wallet_vpc.id
}

resource "aws_route53_zone_association" "feature_domain" {
  count   = var.environment == "dev" ? 1 : 0
  zone_id = aws_route53_zone.feature_domain[0].zone_id
  vpc_id  = aws_vpc.wallet_vpc.id
}
