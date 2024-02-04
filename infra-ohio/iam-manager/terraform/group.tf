module "groups_with_assume_roles" {
  for_each = var.groups

  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"
  version = "~> 4"

  name = each.value.name

  assumable_roles = each.value.assume_roles

  group_users = [for i in var.users : i.id if i.role == each.value.name]

  depends_on = [
    aws_iam_user.users
  ]
}

resource "aws_iam_group_policy" "mfa_policy" {
  for_each = var.groups

  name  = "mfa_policy"
  group = module.groups_with_assume_roles[each.key].group_name	

  policy = "${file("policy/mfa_policy.json")}"
}
