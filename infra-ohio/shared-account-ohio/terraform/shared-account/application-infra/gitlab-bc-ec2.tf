resource "aws_instance" "gitlab_bc_repository" {
  ami                    = var.gitlab_bc_repository_ami
  instance_type          = var.gitlab_bc_repository_instance_type

  iam_instance_profile   = aws_iam_instance_profile.gitlab_profile.id

  vpc_security_group_ids = [aws_security_group.gitlab_sg.id]

  subnet_id              = data.terraform_remote_state.network.outputs.node_subnets[0]
  key_name               = aws_key_pair.ec2_keypair.key_name
  user_data              = file("scripts/user-data.sh")
  disable_api_termination = true

  root_block_device {
    volume_type = "gp3"
  }

  volume_tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-gitlab-bc"
  }

  tags = {
    Name = "ec2-${var.aws_shot_region}-${var.environment}-gitlab-bc",
    Backup = "True"
  }
}

resource "aws_route53_record" "private_gitlab_bc_record" {
  zone_id = data.terraform_remote_state.network.outputs.domain_zone_id
  name    = "gitlab-bc.${data.terraform_remote_state.network.outputs.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.gitlab_bc_repository.private_ip]
}