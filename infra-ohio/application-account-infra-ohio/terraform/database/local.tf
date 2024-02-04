locals {
  marketplace_proxy_ids = [
    for key, id in var.marketplace_mysql_ids : module.secret_value["${key}"].secret_proxy_arn if try(id.username, "") != ""
  ]
  
  launchpad_mysql_ids = [
    for key, id in var.launchpad_mysql_ids : module.secret_value_launch["${key}"].secret_proxy_arn if try(id.username, "") != ""
  ]

  systemadmin_mysql_ids = [
    for key, id in var.systemadmin_mysql_ids : module.secret_value_system["${key}"].secret_proxy_arn if try(id.username, "") != ""
  ]

  web3_middleware_ids = [
    for key, id in var.web3_middleware_ids : module.web3_middleware_secret_value["${key}"].secret_proxy_arn if try(id.username, "") != ""
  ]

  db_users = {
    marketplace = local.marketplace_proxy_ids,
    launchpad = local.launchpad_mysql_ids,
    systemadmin = local.systemadmin_mysql_ids,
    web3_middleware = local.web3_middleware_ids
  }
}
