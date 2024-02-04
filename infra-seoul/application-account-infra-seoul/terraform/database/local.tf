locals {
  centralwallet_proxy_ids = [
    for key, id in var.centralwallet_mysql_ids : module.secret_value_centralwallet["${key}"].secret_proxy_arn if try(id.username, "") != ""
  ]

  db_users = {
    centralwallet = local.centralwallet_proxy_ids
  }
}
