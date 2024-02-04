resource "tls_private_key" "gitlab_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "gitlab_keypair" {
  key_name   = var.gitlab_keypair_name
  public_key = tls_private_key.gitlab_private_key.public_key_openssh
}

resource "tls_private_key" "sonarqube_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "sonarqube_keypair" {
  key_name   = var.sonarqube_keypair_name
  public_key = tls_private_key.sonarqube_private_key.public_key_openssh
}

resource "tls_private_key" "ec2_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_keypair" {
  key_name   = var.ec2_keypair_name
  public_key = tls_private_key.ec2_private_key.public_key_openssh
}
