resource "aws_security_group" "additional_http" {
  name = "allow-ip-http-sg"
  description = "Allow IP sg for http access"
  vpc_id      = aws_vpc.ingress.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = var.exception_ip_list
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-allow-ip-http",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_security_group" "additional_https" {
  name = "allow-ip-https-sg"
  description = "Allow IP sg for http access"
  vpc_id      = aws_vpc.ingress.id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = var.exception_ip_list
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-allow-ip-https",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_security_group" "additional_ssh" {
  name = "allow-ip-ssh-sg"
  description = "Allow IP sg for ssh access"
  vpc_id      = aws_vpc.ingress.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.exception_ip_list
  }

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-allow-ip-ssh",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_security_group" "additional_ssh_2" {
  name = "allow-ip-ssh-sg2"
  description = "Allow IP sg for ssh access"
  vpc_id      = aws_vpc.ingress.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.exception_ip_list2
  }

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-allow-ip-ssh2",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_security_group" "additional_http_2" {
  name = "allow-ip-http-sg2"
  description = "Allow IP sg for http access"
  vpc_id      = aws_vpc.ingress.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = var.exception_ip_list2
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-allow-ip-http",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_security_group" "additional_https_2" {
  name = "allow-ip-https-sg2"
  description = "Allow IP sg for http access"
  vpc_id      = aws_vpc.ingress.id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = var.exception_ip_list2
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-allow-ip-https",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}

resource "aws_security_group" "cf_sg" {
  name = "allow-cf-https-sg"
  description = "Allow IP sg for cf http access"
  vpc_id      = aws_vpc.ingress.id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    prefix_list_ids   = [data.aws_ec2_managed_prefix_list.cloudfront.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-allow-cf-https",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}


resource "aws_security_group" "additional_unity_ssh" {
  name = "allow-unity-ip-ssh-sg"
  description = "Allow IP sg for ssh access"
  vpc_id      = aws_vpc.ingress.id

  ingress {
    from_port        = 1203
    to_port          = 1203
    protocol         = "tcp"
    cidr_blocks      = var.exception_unity_ip_list
  }

  tags = {
    Name = "sg-${var.aws_shot_region}-${var.environment}-allow-unity-ip-ssh",
    System                      = "network",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}