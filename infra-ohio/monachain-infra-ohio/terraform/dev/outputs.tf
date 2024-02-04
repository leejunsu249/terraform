output "monachain_private_key" {
  value     = tls_private_key.monachain_private_key.private_key_pem
  sensitive = true
}
