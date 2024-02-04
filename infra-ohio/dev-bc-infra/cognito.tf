resource "aws_cognito_user_pool" "cognito_marketplace" {
  name = var.marketplace_cognito_name

  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  auto_verified_attributes = ["email"]
  mfa_configuration = "OFF"
  username_attributes = ["email"]

  user_pool_add_ons {
    advanced_security_mode = "OFF"
  }

  password_policy {
    minimum_length = 8
    require_numbers = true
    require_symbols = true
    temporary_password_validity_days = 7
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true
    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  schema {
    name                     = "loginType"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = false
    required                 = false
    string_attribute_constraints {
      min_length = 0
      max_length = 256
    }
  }

  tags = {
    Name = "cog-${var.aws_shot_region}-${var.environment}-${var.service_name}-marketplace-bc",
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_cognito_user_pool_client" "cognito_marketplace_client" {
  name         = "marketplace-client-bc"
  user_pool_id = aws_cognito_user_pool.cognito_marketplace.id

  access_token_validity = 60
  id_token_validity = 60
  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }

  generate_secret     = true
  refresh_token_validity = 3650
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = ["code", "implicit"]
  callback_urls = ["https://localhost:4000/member"]
  allowed_oauth_scopes = [
    "aws.cognito.signin.user.admin",
    "email",
    "openid",
    "phone",
    "profile"
  ]
  supported_identity_providers = ["COGNITO"]
  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]
  prevent_user_existence_errors = "ENABLED"
}

####


resource "aws_cognito_user_pool" "cognito_centralwallet_wallet" {
  name = var.wallet_centralwallet_cognito_name

  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  auto_verified_attributes = ["email"]
  mfa_configuration        = "OFF"
  username_attributes      = ["email"]

  lifecycle { ignore_changes = [schema] }

  user_pool_add_ons {
    advanced_security_mode = "OFF"
  }

  password_policy {
    minimum_length                   = 8
    require_numbers                  = true
    require_symbols                  = true
    temporary_password_validity_days = 7
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true
    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  schema {
    name                     = "loginType"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = false
    required                 = false
    string_attribute_constraints {
      min_length = 0
      max_length = 256
    }
  }

  tags = {
    Name = "cog-${var.aws_shot_region}-${var.environment}-${var.service_name}-centralwallet-bc",
    System                      = "centralwallet",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
  provider = aws.an2
}

resource "aws_cognito_user_pool_client" "cognito_centralwallet_client_wallet" {
  name         = "centralwallet-client-bc"
  user_pool_id = aws_cognito_user_pool.cognito_centralwallet_wallet.id

  access_token_validity = 1
  id_token_validity     = 1
  token_validity_units {
    access_token  = "days"
    id_token      = "days"
    refresh_token = "days"
  }

  generate_secret                      = true
  refresh_token_validity               = 1
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  callback_urls                        = ["https://localhost:4000/member"]
  allowed_oauth_scopes = [
    "aws.cognito.signin.user.admin",
    "email",
    "openid",
    "phone",
    "profile"
  ]
  supported_identity_providers = ["COGNITO"]
  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]
  prevent_user_existence_errors = "ENABLED"
  provider = aws.an2
}

###

resource "aws_cognito_user_pool" "cognito_systemadmin_wallet" {
  name = var.wallet_systemadmin_cognito_name

  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  auto_verified_attributes = ["email"]
  mfa_configuration = "OFF"
  username_attributes = ["email"]

  user_pool_add_ons {
    advanced_security_mode = "OFF"
  }

  password_policy {
    minimum_length = 8
    require_numbers = true
    require_symbols = true
    temporary_password_validity_days = 7
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true
    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  schema {
    name                     = "loginType"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = false
    required                 = false
    string_attribute_constraints {
      min_length = 0
      max_length = 256
    }
  }

  tags = {
    Name = "cog-${var.aws_shot_region}-${var.environment}-${var.service_name}-systemadmin-bc",
    System                      = "systemadmin",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
  provider = aws.an2
}

resource "aws_cognito_user_pool_client" "cognito_systemadmin_client_wallet" {
  name         = "systemadmin-client-bc"
  user_pool_id = aws_cognito_user_pool.cognito_systemadmin_wallet.id

  access_token_validity = 30
  id_token_validity = 30
  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "minutes"
  }

  generate_secret     = true
  refresh_token_validity = 60
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = ["code", "implicit"]
  callback_urls = ["https://localhost:4000/member"]
  allowed_oauth_scopes = [
    "aws.cognito.signin.user.admin",
    "email",
    "openid",
    "phone",
    "profile"
  ]
  supported_identity_providers = ["COGNITO"]
  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]
  prevent_user_existence_errors = "ENABLED"
  provider = aws.an2
}


resource "aws_secretsmanager_secret" "this" {
  for_each = toset(var.secret_names)
  name = "sm-${var.aws_shot_region}-${var.environment}-${var.service_name}-${each.key}"
  kms_key_id = "${var.kms_id}"
}

resource "aws_secretsmanager_secret_version" "this" {
  for_each = aws_secretsmanager_secret.this
  secret_id     = each.value.id
  secret_string = jsonencode(var.temp)
    lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
  depends_on = [
    aws_secretsmanager_secret.this
  ]
}


resource "aws_secretsmanager_secret" "this_an2" {
  for_each = toset(var.secret_names_an2)
  name = "sm-${var.aws_an2_shot_region}-${var.environment}-${var.service_name}-${each.key}"
  kms_key_id = "${var.kms_id}"
  provider = aws.an2
}

resource "aws_secretsmanager_secret_version" "this_an2" {
  for_each = aws_secretsmanager_secret.this_an2
  secret_id     = each.value.id
  secret_string = jsonencode(var.temp)
    lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
  depends_on = [
    aws_secretsmanager_secret.this_an2
  ]
  provider = aws.an2
}