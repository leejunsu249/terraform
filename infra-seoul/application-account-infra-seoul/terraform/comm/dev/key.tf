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


# Terraform apply 시 A duplicate
# resource "tls_private_key" "test_bc_key" {
#   count     = var.environment == "dev" ? 1 : 0
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "test_bc_keypair" {
#   count      = var.environment == "dev" ? 1 : 0
#   key_name   = var.test_bc_keypair_name
#   public_key = tls_private_key.test_bc_key[0].public_key_openssh
# }
