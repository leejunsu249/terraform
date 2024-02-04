# output "name" {
#   description = "A list of all created IAM User objects."
#   value       = {for k,i in aws_iam_user.this: k => i.name}

# }



output "user_info" {
  value = "${formatlist(
    "%s = %s", 
    ("${[ for i in aws_iam_user.this : i.name ]}"),
    ("${[ for i in aws_iam_user_login_profile.this: i.encrypted_password]}")
  )}"
}