resource "aws_route53_zone" "domain" {
  name = var.domain

  vpc {
    vpc_id = aws_vpc.vpc.id
  }

  lifecycle {ignore_changes = [vpc]}

  tags = {
    Network                     = "route53_zone",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = ""
  }
}

resource "aws_route53_zone" "feature_domain" {
  count = var.environment == "dev" ? 1:0

  name = var.feature_domain

  vpc {
    vpc_id = aws_vpc.vpc.id
  }

  lifecycle { ignore_changes = [vpc] }

  tags = {
    Network                     = "route53_zone",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = ""
  }
}
