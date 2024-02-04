resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${var.aws_region_shot}-${var.environment}"
  }
}

resource "aws_vpc_endpoint" "s3-gw-endpoint" {
  vpc_id          = aws_vpc.vpc.id
  service_name    = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = [aws_route_table.private_route.id]

  tags = {
    Name = "vpce-${var.aws_region_shot}-${var.environment}-s3-gw"
  }
}

resource "aws_flow_log" "vpc" {
  log_destination      = "arn:aws:s3:::s3-an2-shd-flow-logs/${var.environment}"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.vpc.id
  tags = {
    Name = "flow-logs-${var.aws_region_shot}-${var.environment}"
  }
}

resource "aws_cloudtrail" "net" {
  name                       = "trail-logs-${var.aws_region_shot}-${var.environment}"
  s3_bucket_name             = "s3-an2-shd-cloudtrail-logs"
  s3_key_prefix              = var.environment
  is_multi_region_trail      = true
  enable_log_file_validation = true
  tags = {
    Name = "trail-logs-${var.aws_region_shot}-${var.environment}"
  }
}
# resource "aws_vpc_endpoint" "ecr-endpoint" {
#   vpc_id       = aws_vpc.vpc.id
#   service_name = "com.amazonaws.${var.aws_region}.ecr.dkr"
#   subnet_ids = [aws_subnet.private_inner_subnet_1.id, aws_subnet.private_inner_subnet_2.id]
#   vpc_endpoint_type = "Interface"
#   security_group_ids = [aws_security_group.endpoint_sg.id]

#   tags = {
#     Name = "vpce-${var.aws_region_shot}-${var.environment}-ecr.dkr"
#   }
# }

# resource "aws_vpc_endpoint" "s3-endpoint" {
#   vpc_id       = aws_vpc.vpc.id
#   service_name = "com.amazonaws.${var.aws_region}.s3"
#   subnet_ids = [aws_subnet.private_inner_subnet_1.id, aws_subnet.private_inner_subnet_2.id]
#   vpc_endpoint_type = "Interface"
#   security_group_ids = [aws_security_group.endpoint_sg.id]

#   tags = {
#     Name = "vpce-${var.aws_region_shot}-${var.environment}-s3"
#   }
# }

# resource "aws_vpc_endpoint" "ecr-api-endpoint" {
#   vpc_id       = aws_vpc.vpc.id
#   service_name = "com.amazonaws.${var.aws_region}.ecr.api"
#   subnet_ids = [aws_subnet.private_inner_subnet_1.id, aws_subnet.private_inner_subnet_2.id]
#   vpc_endpoint_type = "Interface"
#   security_group_ids = [aws_security_group.endpoint_sg.id]

#   tags = {
#     Name = "vpce-${var.aws_region_shot}-${var.environment}-ecr.api"
#   }
# }

# resource "aws_vpc_endpoint" "ec2-endpoint" {
#   vpc_id       = aws_vpc.vpc.id
#   service_name = "com.amazonaws.${var.aws_region}.ec2"
#   subnet_ids = [aws_subnet.private_inner_subnet_1.id, aws_subnet.private_inner_subnet_2.id]
#   vpc_endpoint_type = "Interface"
#   security_group_ids = [aws_security_group.endpoint_sg.id]

#   tags = {
#     Name = "vpce-${var.aws_region_shot}-${var.environment}-ec2"
#   }
# }

# resource "aws_vpc_endpoint" "sts-endpoint" {
#   vpc_id       = aws_vpc.vpc.id
#   service_name = "com.amazonaws.${var.aws_region}.sts"
#   subnet_ids = [aws_subnet.private_inner_subnet_1.id, aws_subnet.private_inner_subnet_2.id]
#   vpc_endpoint_type = "Interface"
#   security_group_ids = [aws_security_group.endpoint_sg.id]

#   tags = {
#     Name = "vpce-${var.aws_region_shot}-${var.environment}-sts"
#   }
# }

# resource "aws_vpc_endpoint" "log-endpoint" {
#   vpc_id       = aws_vpc.vpc.id
#   service_name = "com.amazonaws.${var.aws_region}.logs"
#   subnet_ids = [aws_subnet.private_inner_subnet_1.id, aws_subnet.private_inner_subnet_2.id]
#   vpc_endpoint_type = "Interface"
#   security_group_ids = [aws_security_group.endpoint_sg.id]

#   tags = {
#     Name = "vpce-${var.aws_region_shot}-${var.environment}-logs"
#   }
# }

# resource "aws_vpc_endpoint" "elasticloadbalancing_endpoint" {
#   vpc_id       = aws_vpc.vpc.id
#   service_name = "com.amazonaws.${var.aws_region}.elasticloadbalancing"
#   subnet_ids = [aws_subnet.private_inner_subnet_1.id, aws_subnet.private_inner_subnet_2.id]
#   vpc_endpoint_type = "Interface"
#   security_group_ids = [aws_security_group.endpoint_sg.id]

#   tags = {
#     Name = "vpce-${var.aws_region_shot}-${var.environment}-elasticloadbalancing"
#   }
# }

# resource "aws_vpc_endpoint" "autoscaling_endpoint" {
#   vpc_id       = aws_vpc.vpc.id
#   service_name = "com.amazonaws.${var.aws_region}.autoscaling"
#   subnet_ids = [aws_subnet.private_inner_subnet_1.id, aws_subnet.private_inner_subnet_2.id]
#   vpc_endpoint_type = "Interface"
#   security_group_ids = [aws_security_group.endpoint_sg.id]

#   tags = {
#     Name = "vpce-${var.aws_region_shot}-${var.environment}-autoscaling"
#   }
# }

# resource "aws_security_group" "endpoint_sg" {
#   name        = "vpc_endpoint_sg"
#   description = "ALLOW VPC CIDR"
#   vpc_id      = aws_vpc.vpc.id

#   ingress {
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = [var.vpc_cidr]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = [var.vpc_cidr]
#   }

#   tags = {
#     Name = "sg-${var.aws_region_shot}-${var.environment}-vpce"
#   }
# }
