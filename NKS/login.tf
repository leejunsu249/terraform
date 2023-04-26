resource "ncloud_login_key" "loginkey" {
  key_name = "nks-test-key"
}

resource "local_file" "private_key" {
  filename = "./${ncloud_login_key.loginkey.key_name}.pem"
  content = "ncloud_login_key.loginkey.private_key"
  file_permission = "0400"
}