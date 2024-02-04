locals {
  this_stateful_group_arn  = concat(aws_networkfirewall_rule_group.suricata_stateful_group.*.arn, aws_networkfirewall_rule_group.domain_stateful_group.*.arn, aws_networkfirewall_rule_group.fivetuple_stateful_group.*.arn)
  this_stateless_group_arn = concat(aws_networkfirewall_rule_group.stateless_group.*.arn)
  this_subnet_mapping      = [{ subnet_id : aws_subnet.inspection_private_nfw_subnet_1.id }, { subnet_id : aws_subnet.inspection_private_nfw_subnet_2.id }]
}


resource "aws_networkfirewall_rule_group" "suricata_stateful_group" {
  count = length(var.suricata_stateful_rule_group) > 0 ? length(var.suricata_stateful_rule_group) : 0
  type  = "STATEFUL"

  name        = var.suricata_stateful_rule_group[count.index]["name"]
  description = var.suricata_stateful_rule_group[count.index]["description"]
  capacity    = var.suricata_stateful_rule_group[count.index]["capacity"]
  rules       = var.suricata_stateful_rule_group[count.index]["rules_file"]

  tags = var.suricata_stateful_rule_group[count.index]["name"]
}

resource "aws_networkfirewall_rule_group" "domain_stateful_group" {
  count = length(var.domain_stateful_rule_group) > 0 ? length(var.domain_stateful_rule_group) : 0
  type  = "STATEFUL"

  name        = var.domain_stateful_rule_group[count.index]["name"]
  description = var.domain_stateful_rule_group[count.index]["description"]
  capacity    = var.domain_stateful_rule_group[count.index]["capacity"]

  rule_group {
    dynamic "rule_variables" {
      for_each = lookup(var.domain_stateful_rule_group[count.index], "rule_variables", [])
      content {
        ip_sets {
          key = rule_variables.value["key"]
          ip_set {
            definition = rule_variables.value["ip_set"]
          }
        }
      }
    }

    rules_source {
      rules_source_list {
        generated_rules_type = var.domain_stateful_rule_group[count.index]["actions"]
        target_types         = var.domain_stateful_rule_group[count.index]["protocols"]
        targets              = var.domain_stateful_rule_group[count.index]["domain_list"]
      }
    }
  }

  tags = var.domain_stateful_rule_group[count.index]["name"]
}

resource "aws_networkfirewall_rule_group" "fivetuple_stateful_group" {
  count = length(var.fivetuple_stateful_rule_group) > 0 ? length(var.fivetuple_stateful_rule_group) : 0
  type  = "STATEFUL"

  name        = var.fivetuple_stateful_rule_group[count.index]["name"]
  description = var.fivetuple_stateful_rule_group[count.index]["description"]
  capacity    = var.fivetuple_stateful_rule_group[count.index]["capacity"]

  rule_group {
    rules_source {
      dynamic "stateful_rule" {
        for_each = var.fivetuple_stateful_rule_group[count.index].rule_config
        content {
          action = upper(stateful_rule.value.actions["type"])
          header {
            destination      = stateful_rule.value.destination_ipaddress
            destination_port = stateful_rule.value.destination_port
            direction        = upper(stateful_rule.value.direction)
            protocol         = upper(stateful_rule.value.protocol)
            source           = stateful_rule.value.source_ipaddress
            source_port      = stateful_rule.value.source_port
          }
          rule_option {
            keyword = "sid:1"
          }
        }
      }
    }
  }

  tags = var.fivetuple_stateful_rule_group[count.index]["name"]
}

resource "aws_networkfirewall_rule_group" "stateless_group" {
  count = length(var.stateless_rule_group) > 0 ? length(var.stateless_rule_group) : 0
  type  = "STATELESS"

  name        = var.stateless_rule_group[count.index]["name"]
  description = var.stateless_rule_group[count.index]["description"]
  capacity    = var.stateless_rule_group[count.index]["capacity"]

  rule_group {
    rules_source {
      stateless_rules_and_custom_actions {
        dynamic "stateless_rule" {
          for_each = var.stateless_rule_group[count.index].rule_config
          content {
            priority = stateless_rule.value.priority
            rule_definition {
              actions = ["aws:${stateless_rule.value.actions["type"]}"]
              match_attributes {
                source {
                  address_definition = stateless_rule.value.source_ipaddress
                }
                source_port {
                  from_port = stateless_rule.value.source_from_port
                  to_port   = stateless_rule.value.source_to_port
                }
                destination {
                  address_definition = stateless_rule.value.destination_ipaddress
                }
                destination_port {
                  from_port = stateless_rule.value.destination_from_port
                  to_port   = stateless_rule.value.destination_to_port
                }
                protocols = stateless_rule.value.protocols_number
                tcp_flag {
                  flags = stateless_rule.value.tcp_flag["flags"]
                  masks = stateless_rule.value.tcp_flag["masks"]
                }
              }
            }
          }
        }
      }
    }
  }

  tags = {
    Name = var.stateless_rule_group[count.index]["name"]
  }
}

resource "aws_networkfirewall_firewall_policy" "policy" {
  name = "policy-${var.aws_shot_region}-${var.environment}"

  firewall_policy {
    stateless_default_actions          = ["aws:${var.stateless_default_actions}"]
    stateless_fragment_default_actions = ["aws:${var.stateless_fragment_default_actions}"]

    #Stateless Rule Group Reference
    dynamic "stateless_rule_group_reference" {
      for_each = local.this_stateless_group_arn
      content {
        # Priority is sequentially as per index in stateless_rule_group list 
        priority     = index(local.this_stateless_group_arn, stateless_rule_group_reference.value) + 1
        resource_arn = stateless_rule_group_reference.value
      }
    }

    #StateFul Rule Group Reference
    dynamic "stateful_rule_group_reference" {
      for_each = local.this_stateful_group_arn
      content {
        resource_arn = stateful_rule_group_reference.value
      }
    }
  }
  tags = {
    Name = "policy-${var.aws_shot_region}-${var.environment}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }

  lifecycle {
    ignore_changes = [
      firewall_policy
    ]
  }
}

resource "aws_networkfirewall_firewall" "nfw" {
  name                = "nfw-${var.aws_shot_region}-${var.environment}"
  firewall_policy_arn = aws_networkfirewall_firewall_policy.policy.arn
  vpc_id              = aws_vpc.inspection.id

  dynamic "subnet_mapping" {
    for_each = local.this_subnet_mapping
    content {
      subnet_id = subnet_mapping.value.subnet_id
    }
  }
  delete_protection        = true
  subnet_change_protection = true

  tags = {
    Name = "nfw-${var.aws_shot_region}-${var.environment}",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_networkfirewall_logging_configuration" "nfw" {
  firewall_arn = aws_networkfirewall_firewall.nfw.arn
  logging_configuration {
    log_destination_config {
      log_destination = {
        deliveryStream = aws_kinesis_firehose_delivery_stream.nfw_alert.name
      }
      log_destination_type = "KinesisDataFirehose"
      log_type             = "ALERT"
    }
    log_destination_config {
      log_destination = {
        deliveryStream = aws_kinesis_firehose_delivery_stream.nfw_flow.name
      }
      log_destination_type = "KinesisDataFirehose"
      log_type             = "FLOW"
    }
  }
}
