resource "aws_route53_zone" "domain" {
  name = var.domain

  vpc {
    vpc_id = aws_vpc.egress.id
  }

  tags = {
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}
