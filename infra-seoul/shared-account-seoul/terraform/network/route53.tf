resource "aws_route53_zone" "domain" {
  name = var.domain

  vpc {
    vpc_id = aws_vpc.vpc.id
  }

  lifecycle {ignore_changes = [vpc]}

  tags = {
    "Name" = var.domain,
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}