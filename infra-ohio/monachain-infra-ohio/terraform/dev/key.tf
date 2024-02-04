resource "tls_private_key" "monachain_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "monachain_keypair" {
  key_name   = var.monachain_keypair_name
  public_key = tls_private_key.monachain_private_key.public_key_openssh
}
