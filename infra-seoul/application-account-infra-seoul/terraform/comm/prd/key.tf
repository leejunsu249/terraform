resource "tls_private_key" "ec2_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_keypair" {
  key_name   = var.ec2_keypair_name
  public_key = tls_private_key.ec2_private_key.public_key_openssh
}

resource "tls_private_key" "bcs_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bcs_keypair" {
  key_name   = var.bcs_keypair_name
  public_key = tls_private_key.bcs_private_key.public_key_openssh
}

resource "tls_private_key" "wallet_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "wallet_keypair" {
  key_name   = var.wallet_keypair_name
  public_key = tls_private_key.wallet_private_key.public_key_openssh
}
