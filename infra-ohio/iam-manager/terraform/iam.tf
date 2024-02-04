resource "aws_iam_user" "users" {
  for_each = var.users
  
  name = each.value.id
}

resource "aws_iam_account_password_policy" "shd" {
  minimum_password_length        = 10
  max_password_age = 90
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = false
  require_symbols                = true
  password_reuse_prevention      = 1
  allow_users_to_change_password = true
}

resource "aws_iam_account_password_policy" "dev" {
  provider  = aws.dev

  minimum_password_length        = 10
  max_password_age = 90
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = false
  require_symbols                = true
  password_reuse_prevention      = 1
  allow_users_to_change_password = true
}

resource "aws_iam_account_password_policy" "stg" {
  provider  = aws.stg

  minimum_password_length        = 10
  max_password_age = 90
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = false
  require_symbols                = true
  password_reuse_prevention      = 1
  allow_users_to_change_password = true
}

resource "aws_iam_account_password_policy" "prd" {
  provider  = aws.prd

  minimum_password_length        = 10
  max_password_age = 90
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = false
  require_symbols                = true
  password_reuse_prevention      = 1
  allow_users_to_change_password = true
}

resource "aws_iam_account_password_policy" "net" {
  provider  = aws.net
  
  minimum_password_length        = 10
  max_password_age = 90
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = false
  require_symbols                = true
  password_reuse_prevention      = 1
  allow_users_to_change_password = true
}