resource "aws_iam_service_linked_role" "opensearch" {
  aws_service_name = "es.amazonaws.com"
}

resource "aws_elasticsearch_domain" "opensearch" {
  domain_name           = "opensearch-${var.aws_shot_region}-${var.environment}-${var.service_name}"
  elasticsearch_version = "OpenSearch_${var.cluster_version}"

  cluster_config {
    instance_type = var.instance_type
    instance_count = var.instance_count

    zone_awareness_enabled = true

    zone_awareness_config {
      availability_zone_count = var.availability_zone_count
    }

    dedicated_master_enabled = var.dedicated_master_enabled
    dedicated_master_type = var.master_instance_type
    dedicated_master_count = var.master_instance_count
  }

  access_policies = data.aws_iam_policy_document.os_access_policy.json

  vpc_options {
    subnet_ids = var.subnet_ids

    security_group_ids = [aws_security_group.opensearch.id]
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = true
    "override_main_response_version" = false
  }

  advanced_security_options {
    enabled = true

    master_user_options {
      master_user_arn = "${aws_iam_role.opensearch_master_role.arn}/blingsurio@lgcns.com"
    }
  }

  cognito_options {
    enabled = true
    user_pool_id = "us-east-2_DkFx06kwV"
    identity_pool_id = "us-east-2:21127727-d63d-46f8-ac89-5e1868f26b03"
    role_arn = aws_iam_role.cognito_os_role.arn
  }

  node_to_node_encryption {
    enabled = true
  }

  encrypt_at_rest {
    enabled = true
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  dynamic "ebs_options" {
    for_each = var.storage_options

    content {
      ebs_enabled = lookup(ebs_options.value, "ebs_enabled", null)
      volume_size = lookup(ebs_options.value, "volume_size", null)
      iops        = lookup(ebs_options.value, "iops", null)
      volume_type = lookup(ebs_options.value, "volume_type", null)
    }
  }

  auto_tune_options {
    desired_state = "DISABLED"
    rollback_on_disable = "NO_ROLLBACK"
  }

  domain_endpoint_options {
    enforce_https = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  depends_on = [aws_iam_service_linked_role.opensearch]

  tags = {
    Name = "opensearch-${var.aws_shot_region}-${var.environment}-${var.service_name}",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
}
