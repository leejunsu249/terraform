resource "tls_private_key" "ec2_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_keypair" {  
  key_name   = var.ec2_keypair_name
  public_key = tls_private_key.ec2_private_key.public_key_openssh
}

resource "tls_private_key" "lena_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "lena_keypair" {
  key_name   = var.lena_keypair_name
  public_key = tls_private_key.lena_private_key.public_key_openssh
}

resource "tls_private_key" "tuna_private_key" {
 
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "tuna_keypair" {
  key_name   = var.tuna_keypair_name
  public_key = tls_private_key.tuna_private_key.public_key_openssh
}

### bcs key pair
resource "tls_private_key" "bcs_private_key" {
  count     = var.environment == "stg" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bcs_keypair" {
  count      = var.environment == "stg" ? 1 : 0
  key_name   = "bcs-key"
  public_key = tls_private_key.bcs_private_key[0].public_key_openssh
}

### search key pair
resource "tls_private_key" "search_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "search_keypair" {  
  key_name   = "search-key"
  public_key = tls_private_key.search_private_key.public_key_openssh
}
