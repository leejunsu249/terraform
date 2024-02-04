# resource "random_password" "mariadb_password" {
#   length  = 16
#   special = true
# }

# resource "aws_secretsmanager_secret" "mariadb_password" {
#   name = "sm-ue2-dev-naemo-monamgr_pw"
# }

# resource "aws_secretsmanager_secret_version" "secret_value_credentials" {
#   secret_id     = aws_secretsmanager_secret.mariadb_password.id
#   secret_string = random_password.mariadb_password.result
# }