# data "aws_cloudwatch_log_group" "eks_loggroup_name" {
#   name = var.eks_loggroup_name
# }

# data "archive_file" "os_log_archive" {
#   type        = "zip"
#   source_file = "${path.module}/lambda/index.js"
#   output_path = "${path.module}/lambda/os_log.zip"
# }

# resource "aws_iam_role" "cloudwatch_sub_os_lambda_role" {
#   name = "cloudwatch-sub-os-lambda-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         "Action": "sts:AssumeRole",
#         "Principal": {
#           "Service": "lambda.amazonaws.com"
#         },
#         "Effect": "Allow"
#       }
#     ]
#   })

#   tags = {
#     Name = "iamr-${var.aws_shot_region}-${var.environment}-${var.service_name}-cloudwatch-sub-os-lambda"
#   }
# }

# resource "aws_iam_role_policy" "cloudwatch_sub_os_lambda_policy" {
#   name = "cloudwatch-sub-os-lambda-policy"
#   role = aws_iam_role.cloudwatch_sub_os_lambda_role.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         "Sid": "LambdaOpensearchAccessExcutionRole3",
#         "Effect": "Allow",
#         "Action": [
#           "es:ESHttpPost"
#         ],
#         "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain}/*"
#       },
#       {
#         "Sid": "CopiedFromTemplateAWSLambdaVPCAccessExecutionRole1",
#         "Effect": "Allow",
#         "Action": [
#           "ec2:CreateNetworkInterface"
#         ],
#         "Resource": "*"
#       },
#       {
#         "Sid": "CopiedFromTemplateAWSLambdaVPCAccessExecutionRole2",
#         "Effect": "Allow",
#         "Action": [
#           "ec2:DescribeNetworkInterfaces",
#           "ec2:DeleteNetworkInterface"
#         ],
#         "Resource": "*"
#       },
#       {
#         "Sid": "CopiedFromTemplateAWSLambdaBasicExecutionRole1",
#         "Effect": "Allow",
#         "Action": "logs:CreateLogGroup",
#         "Resource": "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
#       },
#       {
#         "Sid": "CopiedFromTemplateAWSLambdaBasicExecutionRole2",
#         "Effect": "Allow",
#         "Action": [
#           "logs:CreateLogStream",
#           "logs:PutLogEvents"
#         ],
#         "Resource": [
#           "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${data.aws_cloudwatch_log_group.eks_loggroup_name.name}/*"
#         ]
#       },
#       {
#         "Sid": "CopiedFromTemplateAWSLambdaAMIExecutionRole",
#         "Effect": "Allow",
#         "Action": [
#           "ec2:DescribeImages"
#         ],
#         "Resource": "*"
#       },
#       {
#         "Effect": "Allow",
#         "Action": [
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents"
#         ],
#         "Resource": "arn:aws:logs:*:*:*"
#       },
#       {
#         "Effect": "Allow",
#         "Action": [
#           "lambda:InvokeFunction"
#         ],
#         "Resource": [
#           "*"
#         ]
#       }
#     ]
#   })
# }

# resource "aws_lambda_function" "cloudwatch_sub_os_lambda" {
#   function_name    = var.sub_os_lambda_name
#   filename         = "${path.module}/lambda/os_log.zip"
#   source_code_hash = data.archive_file.os_log_archive.output_base64sha256
#   handler          = "index.handler"

#   role        = aws_iam_role.cloudwatch_sub_os_lambda_role.arn
#   memory_size = "128"
#   runtime     = "nodejs14.x"

#   timeout = "15"

#   environment {
#     variables = {
#       OS_ENDPOINT = aws_elasticsearch_domain.opensearch.endpoint
#     }
#   }

#   vpc_config {
#     subnet_ids         = var.subnet_ids
#     security_group_ids = [aws_security_group.lambda.id]
#   }

#   tags = {
#     Name = "lambda-${var.aws_shot_region}-${var.environment}-${var.service_name}-${var.sub_os_lambda_name}"
#   }
# }

# resource "aws_lambda_permission" "allow_cloudwatch" {
#   statement_id  = "allow-cloudwatch"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.cloudwatch_sub_os_lambda.arn
#   principal     = "logs.${data.aws_region.current.name}.amazonaws.com"
#   source_arn    = "${data.aws_cloudwatch_log_group.eks_loggroup_name.arn}:*"
# }

# resource "aws_cloudwatch_log_subscription_filter" "cloudwatch_sub_os_lambda" {
#   depends_on      = [aws_lambda_permission.allow_cloudwatch]

#   name            = var.sub_os_lambda_name
#   log_group_name  = data.aws_cloudwatch_log_group.eks_loggroup_name.name
#   filter_pattern  = ""
#   destination_arn = aws_lambda_function.cloudwatch_sub_os_lambda.arn
# }