output "dev_user_info" {
  description = "The user's name"
  value       = module.dev_users
}

output "dev_group_info" {
  description = "The group's name"
  value       = module.dev_group.group_name
}

