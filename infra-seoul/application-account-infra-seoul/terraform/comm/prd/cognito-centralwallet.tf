resource "aws_cognito_user_pool" "cognito_centralwallet" {
  name = var.centralwallet_cognito_name

  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  auto_verified_attributes = ["email"]
  mfa_configuration = "OFF"
  username_attributes = ["email"]

  lifecycle { ignore_changes = [schema] }

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
    Name = "cog-${var.aws_shot_region}-${var.environment}-${var.service_name}-centralwallet",
    System                      = "centralwallet",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }  
}

resource "aws_cognito_user_pool_client" "cognito_centralwallet_client" {
  name         = "centralwallet-client"
  user_pool_id = aws_cognito_user_pool.cognito_centralwallet.id

  access_token_validity = 1
  id_token_validity = 1
  token_validity_units {
    access_token  = "days"
    id_token      = "days"
    refresh_token = "days"
  }

  generate_secret     = true
  refresh_token_validity = 30
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