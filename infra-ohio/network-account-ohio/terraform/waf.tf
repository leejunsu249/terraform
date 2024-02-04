## non-production

resource "aws_wafv2_ip_set" "fe_non_prod_allowed_ipset" {
  provider           = aws.virginia
  name               = "fe_non_prod_allowed_ipset"
  description        = "IP set"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses          = concat(var.exception_ip_list, var.exception_ip_list2)

  tags = {
    System                      = "security",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_wafv2_rule_group" "fe_non_prod_waf_rule" {
  provider = aws.virginia
  name     = "fe_non_prod_waf_rule"
  scope    = "CLOUDFRONT"
  capacity = 1

  rule {
    name     = "ALLOW_IP"
    priority = 1

    action {
      allow {}
    }

    statement {

      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.fe_non_prod_allowed_ipset.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "fe_non_prod_waf_rule_allow_ip"
      sampled_requests_enabled   = true
    }
  }
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "fe_non_prod_waf_rule"
    sampled_requests_enabled   = true
  }

  tags = {
    System                      = "security",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_wafv2_web_acl" "fe_non_prod_web_acl" {
  provider    = aws.virginia
  name        = "fe_non_prod_web_acl"
  description = "fe_non_prod_web_acl"
  scope       = "CLOUDFRONT"

  default_action {
    block {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "fe_non_prod_web_acl"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "AWS-AWSManagedRulesAdminProtectionRuleSet"
    priority = 0

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAdminProtectionRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesAdminProtectionRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWS-AWSManagedRulesAmazonIpReputationList"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWS-AWSManagedRulesAmazonIpReputationList"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 2

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        excluded_rule {
          name = "SizeRestrictions_BODY"
        }

        scope_down_statement {
          not_statement {
            statement {
              byte_match_statement {
                positional_constraint = "CONTAINS_WORD"
                search_string = "style"
                
                field_to_match {
                  body {}
                }
                
                text_transformation {
                  priority = 0
                  type = "NONE"
                }
              }
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
    priority = 3

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWS-AWSManagedRulesSQLiRuleSet"
    priority = 4

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesSQLiRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "ALLOW_IP"
    priority = 5

    override_action {
      none {}
    }

    statement {
      rule_group_reference_statement {
        arn = aws_wafv2_rule_group.fe_non_prod_waf_rule.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "fe_non_prod_web_acl_allow_ip"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWS-AWSManagedRulesAnonymousIpList"
    priority = 6

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAnonymousIpList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesAnonymousIpList"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "ALLOW_NFT_METADATA"
    priority = 7

    action {
      allow {}
    }

    statement {
      byte_match_statement {
        field_to_match {
          uri_path {}
        }
        positional_constraint = "STARTS_WITH"
        search_string         = "/nft/nft_metadata/"
        text_transformation {
          priority = 0
          type     = "NONE"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "fe_non_prod_web_acl_allow_nft_metadata"
      sampled_requests_enabled   = true
    }
  }
}

resource "aws_wafv2_web_acl_logging_configuration" "fe_non_prod_waf_logging" {
  provider                = aws.virginia
  log_destination_configs = [aws_kinesis_firehose_delivery_stream.waf_non_prd.arn]
  resource_arn            = aws_wafv2_web_acl.fe_non_prod_web_acl.arn
  redacted_fields {
  }
  depends_on = [
    aws_kinesis_firehose_delivery_stream.waf_non_prd
  ]
}

## production
resource "aws_wafv2_rule_group" "fe_prod_waf_rule" {
  provider = aws.virginia
  name     = "fe_prod_waf_rule"
  scope    = "CLOUDFRONT"
  capacity = 1

  rule {
    name     = "ALLOW_IP"
    priority = 1

    action {
      allow {}
    }

    statement {

      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.fe_non_prod_allowed_ipset.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "fe_prod_waf_rule_allow_ip"
      sampled_requests_enabled   = true
    }
  }


  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "fe_prod_waf_rule"
    sampled_requests_enabled   = true
  }

  tags = {
    System                      = "security",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}

resource "aws_wafv2_web_acl" "fe_prod_web_acl" {
  provider    = aws.virginia
  name        = "fe_prod_web_acl"
  description = "fe_prod_web_acl"
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "fe_prod_web_acl"
    sampled_requests_enabled   = true
  }

  # rule {
  #   name     = "ALLOW_NFT_METADATA"
  #   priority = 0

  #   action {
  #     block {}
  #   }

  #   statement {
  #     byte_match_statement {
  #       field_to_match {
  #         uri_path {}
  #       }
  #       positional_constraint = "STARTS_WITH"
  #       search_string         = "/nft/nft_metadata/"
  #       text_transformation {
  #         priority = 0
  #         type     = "NONE"
  #       }
  #     }
  #   }

  #   visibility_config {
  #     cloudwatch_metrics_enabled = true
  #     metric_name                = "fe_prod_web_acl_allow_nft_metadata"
  #     sampled_requests_enabled   = true
  #   }
  # }

  # rule {
  #   name     = "ALLOW_NFT_THUMBNAIL"
  #   priority = 1

  #   action {
  #     block {}
  #   }

  #   statement {
  #     byte_match_statement {
  #       field_to_match {
  #         uri_path {}
  #       }
  #       positional_constraint = "STARTS_WITH"
  #       search_string         = "/nft/nft_thumbnail/"
  #       text_transformation {
  #         priority = 0
  #         type     = "NONE"
  #       }
  #     }
  #   }

  #   visibility_config {
  #     cloudwatch_metrics_enabled = true
  #     metric_name                = "fe_prod_web_acl_allow_nft_thumbnail"
  #     sampled_requests_enabled   = true
  #   }
  # }

  rule {
    name     = "AWS-AWSManagedRulesAdminProtectionRuleSet"
    priority = 0

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAdminProtectionRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesAdminProtectionRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWS-AWSManagedRulesAmazonIpReputationList"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWS-AWSManagedRulesAmazonIpReputationList"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWS-AWSManagedRulesAnonymousIpList"
    priority = 2

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAnonymousIpList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesAnonymousIpList"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 3

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        excluded_rule {
          name = "SizeRestrictions_BODY"
        }

        scope_down_statement {
          not_statement {
            statement {
              byte_match_statement {
                positional_constraint = "CONTAINS_WORD"
                search_string = "style"
                
                field_to_match {
                  body {}
                }
                
                text_transformation {
                  priority = 0
                  type = "NONE"
                }
              }
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
    priority = 4

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWS-AWSManagedRulesSQLiRuleSet"
    priority = 5

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesSQLiRuleSet"
      sampled_requests_enabled   = true
    }
  }
}

resource "aws_wafv2_web_acl_logging_configuration" "fe_prod_waf_logging" {
  provider                = aws.virginia
  log_destination_configs = [aws_kinesis_firehose_delivery_stream.waf_prd.arn]
  resource_arn            = aws_wafv2_web_acl.fe_prod_web_acl.arn
  redacted_fields {
  }
  depends_on = [
    aws_kinesis_firehose_delivery_stream.waf_prd
  ]
}
