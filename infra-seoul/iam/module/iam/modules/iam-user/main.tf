resource "aws_iam_user" "this" {
  for_each             = var.create_user ? var.name : []
  name                 = each.key
  path                 = var.path
  force_destroy        = var.force_destroy
  permissions_boundary = var.permissions_boundary

  tags = var.tags
}

resource "aws_iam_user_login_profile" "this" {
  for_each             = var.create_user ? var.name : []
  user                    = each.key
  pgp_key                 = var.pgp_key
  password_length         = var.password_length
  password_reset_required = var.password_reset_required

  # TODO: Remove once https://github.com/hashicorp/terraform-provider-aws/issues/23567 is resolved
  lifecycle {
    ignore_changes = [password_reset_required]
  }
  depends_on = [
    aws_iam_user.this
  ]
}



