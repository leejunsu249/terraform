# locals {
#   cloudfront_oai-new = var.environment == "dev" ? [
#       "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.cloudfront_marketplace_oai}",
#       "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.cloudfront_marketplace_next_oai}",
#       "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E18O1Y8J8XT6MG"] : ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.cloudfront_marketplace_oai}"]
# }



# resource "aws_s3_bucket" "nft_bucket-new" {
#   bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-nft-new"

#   tags = {
#     Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-nft-new",
#     System                      = "common",
#     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
#     SupportPlatformOwnerPrimary = "BithumMeta",
#     OperationLevel              = "3"
#   }  
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "nft_bucket-new" {
#   bucket = aws_s3_bucket.nft_bucket-new.bucket

#   rule {
#     bucket_key_enabled = false 

#   	apply_server_side_encryption_by_default {
#   		sse_algorithm = "AES256"
#   	}
# 	}
# }

# resource "aws_s3_bucket_public_access_block" "nft_bucket-new" {
#   bucket = aws_s3_bucket.nft_bucket-new.id

#   block_public_acls   = true
#   ignore_public_acls  = true
#   block_public_policy = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket_cors_configuration" "nft_bucket-new" {
#   bucket = aws_s3_bucket.nft_bucket.bucket

#   cors_rule {
#     allowed_headers = ["*"]
#     allowed_methods = ["GET", "POST"]
#     allowed_origins = ["*"]
#     expose_headers  = []
#   }
# }

# resource "aws_s3_bucket_policy" "nft_bucket-new" {
#   bucket = aws_s3_bucket.nft_bucket-new.id
#   policy = data.aws_iam_policy_document.nft_bucket_policy-new.json
# }

# data "aws_iam_policy_document" "nft_bucket_policy-new" {
#   source_policy_documents = [
#     data.aws_iam_policy_document.allow_acess_extension_nft_bucket-new.json,
#     data.aws_iam_policy_document.nft_bucket_s3_secure_transport-new.json,
#     data.aws_iam_policy_document.allow_acess_nft_bucket_from_unity-new.json
#   ]
# }

# data "aws_iam_policy_document" "nft_bucket_s3_secure_transport-new" {
#     statement {
#     effect = "Deny"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }
#     actions = [
#       "s3:*",
#     ]
#     resources = [
#     "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*",
#     "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}"

#     ]
    
#     condition {
#      test     = "Bool"
#      variable =  "aws:SecureTransport"
#      values = ["false"]
#    }
#  }
# }

# data "aws_iam_policy_document" "allow_acess_extension_nft_bucket-new" {
#   statement {
#     effect = "Deny"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }

#     actions = [
#       "s3:PutObject",
#     ]
#     not_resources = [
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.jpg",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.jpeg",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.png",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.gif",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.mp4",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.avi",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.mp3",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.mav",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.ogg",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.gltf",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.glb",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.zip",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.json",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.wav",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.svg",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.JPG",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.JPEG",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.PNG",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.GIF",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.MP4",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.AVI",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.MP3",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.MAV",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.OGG",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.GLTF",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.GLB",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.ZIP",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.JSON",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.WAV",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.SVG",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*.webp"
#     ]
#   }
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = local.cloudfront_oai-new
#     }

#     actions = [
#       "s3:GetObject",
#     ]
#     resources = [
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}"
#     ]
#   }

#   statement {
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = ["arn:aws:iam::351894368755:role/lambda-edge-role",
#       "arn:aws:iam::385866877617:role/marketplace_bottlerocket_node-eks-node-group" ]
#     }

#     actions = [
#       "s3:GetObject",
#       "s3:PutObject"
#     ]
#     resources = [
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}"
#     ]
#   }
# }

# data "aws_iam_policy_document" "allow_acess_nft_bucket_from_unity-new" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = ["${var.unity_s3_role_name}"]
#     }

#     actions = [
#       "s3:GetObject"
#     ]
#     resources = [
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}/*",
#       "arn:aws:s3:::${aws_s3_bucket.nft_bucket-new.id}"
#     ]
#   }
# }

# resource "aws_s3_bucket_ownership_controls" "nft_bucket-new" {
#   bucket = aws_s3_bucket.nft_bucket-new.id

#   rule {
#     object_ownership = "BucketOwnerEnforced"
#   }
# }


# ### 마켓 플레이스 new s3 ## 

# resource "aws_s3_bucket" "fe-marketplace-new_bucket" {
#   count = var.environment == "dev" ? 1:0

#   bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-marketplace-new"

#   tags = {
#     Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-marketplace-new",
#     System                      = "marketplace",
#     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
#     SupportPlatformOwnerPrimary = "BithumMeta",
#     OperationLevel              = "2"
#   }  
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "fe-marketplace-new_bucket" {
#   count = var.environment == "dev" ? 1:0

#   bucket = aws_s3_bucket.fe-marketplace-new_bucket[0].bucket

#   rule {
#     bucket_key_enabled = false 

#   	apply_server_side_encryption_by_default {
#   		sse_algorithm = "AES256"
#   	}
# 	}
# }

# resource "aws_s3_bucket_public_access_block" "fe-marketplace-new_bucket" {
#   count = var.environment == "dev" ? 1:0

#   bucket = aws_s3_bucket.fe-marketplace-new_bucket[0].id

#   block_public_acls   = true
#   ignore_public_acls  = true
#   block_public_policy = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket_policy" "fe-marketplace-new_bucket" {
#   count = var.environment == "dev" ? 1:0

#   bucket = aws_s3_bucket.fe-marketplace-new_bucket[0].id
#   policy = data.aws_iam_policy_document.fe-marketplace-new_bucket_policy[0].json
# }

# data "aws_iam_policy_document" "fe-marketplace-new_bucket_policy" {
#   count = var.environment == "dev" ? 1:0

#   source_policy_documents = [
#     data.aws_iam_policy_document.fe-marketplace-new_bucket[0].json,
#     data.aws_iam_policy_document.fe-marketplace-new_bucket_s3_secure_transport[0].json ## 수정
#   ]
# }

# data "aws_iam_policy_document" "fe-marketplace-new_bucket_s3_secure_transport" {
#   count = var.environment == "dev" ? 1:0
#     statement {
#     effect = "Deny"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }
#     actions = [
#       "s3:*",
#     ]
#     resources = [
#     "arn:aws:s3:::${aws_s3_bucket.fe-marketplace-new_bucket[0].id}/*",
#     "arn:aws:s3:::${aws_s3_bucket.fe-marketplace-new_bucket[0].id}"

#     ]
    
#     condition {
#      test     = "Bool"
#      variable =  "aws:SecureTransport"
#      values = ["false"]
#    }
#  }
# }



# data "aws_iam_policy_document" "fe-marketplace-new_bucket" {
#   count = var.environment == "dev" ? 1:0

#   statement {
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.cloudfront_marketplace_bc_oai}"]
#     }

#     actions = [
#       "s3:GetObject",
#     ]
#     resources = [
#       "arn:aws:s3:::${aws_s3_bucket.fe-marketplace-new_bucket[0].id}/*",
#       "arn:aws:s3:::${aws_s3_bucket.fe-marketplace-new_bucket[0].id}"
#     ]
#   }
# }

# resource "aws_s3_bucket_ownership_controls" "fe-marketplace-new_bucket" {
#   count = var.environment == "dev" ? 1:0

#   bucket = aws_s3_bucket.fe-marketplace-new_bucket[0].id

#   rule {
#     object_ownership = "BucketOwnerEnforced"
#   }
# }

# ### member bucket ### 

# resource "aws_s3_bucket" "member_bucket-new" {
#   bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-member-new"

#   tags = {
#     Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-member-new",
#     System                      = "marketplace",
#     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
#     SupportPlatformOwnerPrimary = "BithumMeta",
#     OperationLevel              = "2"
#   }  
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "member_bucket-new" {
#   bucket = aws_s3_bucket.member_bucket-new.bucket

#   rule {
#     bucket_key_enabled = false 

#   	apply_server_side_encryption_by_default {
#   		sse_algorithm = "AES256"
#   	}
# 	}
# }

# resource "aws_s3_bucket_public_access_block" "member_bucket-new" {
#   bucket = aws_s3_bucket.member_bucket-new.id

#   block_public_acls   = true
#   ignore_public_acls  = true
#   block_public_policy = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket_cors_configuration" "member_bucket-new" {
#   bucket = aws_s3_bucket.member_bucket-new.bucket

#   cors_rule {
#     allowed_headers = ["*"]
#     allowed_methods = ["GET", "POST"]
#     allowed_origins = ["*"]
#     expose_headers  = []
#   }
# }

# resource "aws_s3_bucket_policy" "member_bucket-new" {
#   bucket = aws_s3_bucket.member_bucket-new.id
#   policy = data.aws_iam_policy_document.member_bucket_policy-new.json
# }

# data "aws_iam_policy_document" "member_bucket_policy-new" {
#   source_policy_documents = [
#     data.aws_iam_policy_document.allow_acess_extension_member_bucket-new.json,
#     data.aws_iam_policy_document.member_bucket_s3_secure_transport-new.json,
#     data.aws_iam_policy_document.allow_acess_member_bucket_from_unity-new.json
#   ]
# }

# data "aws_iam_policy_document" "member_bucket_s3_secure_transport-new" {
#    statement {
#     effect = "Deny"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }
#     actions = [
#       "s3:*",
#     ]
#     resources = [
#     "arn:aws:s3:::${aws_s3_bucket.member_bucket-new.id}/*",
#     "arn:aws:s3:::${aws_s3_bucket.member_bucket-new.id}"

#     ]
    
#     condition {
#      test     = "Bool"
#      variable =  "aws:SecureTransport"
#      values = ["false"]
#    }
#  }
# }

# data "aws_iam_policy_document" "allow_acess_extension_member_bucket-new" {
#   statement {
#     effect = "Deny"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }

#     actions = [
#       "s3:PutObject",
#     ]
#     not_resources = [
#       "arn:aws:s3:::${aws_s3_bucket.member_bucket-new.id}/*.jpg",
#       "arn:aws:s3:::${aws_s3_bucket.member_bucket-new.id}/*.jpeg",
#       "arn:aws:s3:::${aws_s3_bucket.member_bucket-new.id}/*.png",
#       "arn:aws:s3:::${aws_s3_bucket.member_bucket-new.id}/*.gif",
#       "arn:aws:s3:::${aws_s3_bucket.member_bucket-new.id}/*.svg",
#       "arn:aws:s3:::${aws_s3_bucket.member_bucket-new.id}/*.JPG",
#       "arn:aws:s3:::${aws_s3_bucket.member_bucket-new.id}/*.JPEG",
#       "arn:aws:s3:::${aws_s3_bucket.member_bucket-new.id}/*.PNG",
#       "arn:aws:s3:::${aws_s3_bucket.member_bucket-new.id}/*.GIF",
#       "arn:aws:s3:::${aws_s3_bucket.member_bucket-new.id}/*.SVG"
#     ]
#   }
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = local.cloudfront_oai-new
#     }

#     actions = [
#       "s3:GetObject",
#     ]
#     resources = [
#       "arn:aws:s3:::${aws_s3_bucket.member_bucket-new.id}/*",
#       "arn:aws:s3:::${aws_s3_bucket.member_bucket-new.id}"
#     ]
#   }

# }

# data "aws_iam_policy_document" "allow_acess_member_bucket_from_unity-new" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = ["${var.unity_s3_role_name}"]
#     }

#     actions = [
#       "s3:GetObject"
#     ]
#     resources = [
#       "arn:aws:s3:::${aws_s3_bucket.member_bucket-new.id}/*",
#       "arn:aws:s3:::${aws_s3_bucket.member_bucket-new.id}"
#     ]
#   }
# }

# resource "aws_s3_bucket_ownership_controls" "member_bucket-new" {
#   bucket = aws_s3_bucket.member_bucket-new.id

#   rule {
#     object_ownership = "BucketOwnerEnforced"
#   }
# }

# ### comm s3 

# resource "aws_s3_bucket" "comm_bucket-new" {
#   bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-comm-new"

#   tags = {
#     Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-comm-new",
#     System                      = "marketplace",
#     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
#     SupportPlatformOwnerPrimary = "BithumMeta",
#     OperationLevel              = "2"
#   }  
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "comm_bucket-new" {
#   bucket = aws_s3_bucket.comm_bucket-new.bucket

#   rule {
#     bucket_key_enabled = false 

#   	apply_server_side_encryption_by_default {
#   		sse_algorithm = "AES256"
#   	}
# 	}
# }

# resource "aws_s3_bucket_public_access_block" "comm_bucket-new" {
#   bucket = aws_s3_bucket.comm_bucket-new.id

#   block_public_acls   = true
#   ignore_public_acls  = true
#   block_public_policy = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket_cors_configuration" "comm_bucket-new" {
#   bucket = aws_s3_bucket.comm_bucket-new.bucket

#   cors_rule {
#     allowed_headers = ["*"]
#     allowed_methods = ["GET", "POST"]
#     allowed_origins = ["*"]
#     expose_headers  = []
#   }
# }

# resource "aws_s3_bucket_policy" "comm_bucket-new" {
#   bucket = aws_s3_bucket.comm_bucket-new.id
#   policy = data.aws_iam_policy_document.comm_bucket_policy-new.json
# }

# data "aws_iam_policy_document" "comm_bucket_policy-new" {
#   source_policy_documents = [
#     data.aws_iam_policy_document.allow_acess_extension_comm_bucket-new.json,
#     data.aws_iam_policy_document.comm_bucket_s3_secure_transport-new.json,
#     data.aws_iam_policy_document.allow_acess_comm_bucket_from_unity-new.json
#   ]
# }

# data "aws_iam_policy_document" "comm_bucket_s3_secure_transport-new" {
#    statement {
#     effect = "Deny"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }
#     actions = [
#       "s3:*",
#     ]
#     resources = [
#     "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}/*",
#     "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}"

#     ]
    
#     condition {
#      test     = "Bool"
#      variable =  "aws:SecureTransport"
#      values = ["false"]
#    }
#  }
# }

# data "aws_iam_policy_document" "allow_acess_extension_comm_bucket-new" {
#   statement {
#     effect = "Deny"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }

#     actions = [
#       "s3:PutObject",
#     ]
#     not_resources = [
#       "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}/*.jpg",
#       "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}/*.jpeg",
#       "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}/*.png",
#       "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}/*.gif",
#       "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}/*.svg",
#       "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}/*.JPG",
#       "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}/*.JPEG",
#       "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}/*.PNG",
#       "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}/*.GIF",
#       "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}/*.SVG"
#     ]
#   }
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = local.cloudfront_oai-new
#     }

#     actions = [
#       "s3:GetObject",
#     ]
#     resources = [
#       "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}/*",
#       "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}"
#     ]
#   }
#     statement {
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = ["arn:aws:iam::351894368755:role/lambda-edge-role"]
#     }

#     actions = [
#       "s3:GetObject",
#       "s3:PutObject"
#     ]
#     resources = [
#       "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}/*",
#       "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}"
#     ]
#   }
# }

# data "aws_iam_policy_document" "allow_acess_comm_bucket_from_unity-new" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = ["${var.unity_s3_role_name}"]
#     }

#     actions = [
#       "s3:GetObject"
#     ]
#     resources = [
#       "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}/*",
#       "arn:aws:s3:::${aws_s3_bucket.comm_bucket-new.id}"
#     ]
#   }
# }

# resource "aws_s3_bucket_ownership_controls" "comm_bucket-new" {
#   bucket = aws_s3_bucket.comm_bucket-new.id

#   rule {
#     object_ownership = "BucketOwnerEnforced"
#   }
# }

# ## launchpad ###

# resource "aws_s3_bucket" "launchpad_bucket-new" {
#   bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-launchpad-new"

#   tags = {
#     Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-launchpad-new",
#     System                      = "launchpad",
#     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
#     SupportPlatformOwnerPrimary = "BithumMeta",
#     OperationLevel              = "2"
#   }  
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "launchpad_bucket-new" {
#   bucket = aws_s3_bucket.launchpad_bucket-new.bucket

#   rule {
#     bucket_key_enabled = false 

#   	apply_server_side_encryption_by_default {
#   		sse_algorithm = "AES256"
#   	}
# 	}
# }

# resource "aws_s3_bucket_public_access_block" "launchpad_bucket-new" {
#   bucket = aws_s3_bucket.launchpad_bucket-new.id

#   block_public_acls   = true
#   ignore_public_acls  = true
#   block_public_policy = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket_cors_configuration" "launchpad_bucket-new" {
#   bucket = aws_s3_bucket.launchpad_bucket-new.bucket

#   cors_rule {
#     allowed_headers = ["*"]
#     allowed_methods = ["GET", "POST"]
#     allowed_origins = ["*"]
#     expose_headers  = []
#   }
# }

# resource "aws_s3_bucket_policy" "launchpad_bucket-new" {
#   bucket = aws_s3_bucket.launchpad_bucket-new.id
#   policy = data.aws_iam_policy_document.launchpad_bucket-new_policy.json
# }

# data "aws_iam_policy_document" "launchpad_bucket-new_policy" {
#   source_policy_documents = [
#     data.aws_iam_policy_document.allow_acess_extension_launchpad_bucket-new.json,
#     data.aws_iam_policy_document.launchpad_bucket-new_s3_secure_transport.json
#   ]
# }

# data "aws_iam_policy_document" "launchpad_bucket-new_s3_secure_transport" {
#     statement {
#     effect = "Deny"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }
#     actions = [
#       "s3:*",
#     ]
#     resources = [
#     "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-new.id}/*",
#     "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-new.id}"

#     ]
    
#     condition {
#      test     = "Bool"
#      variable =  "aws:SecureTransport"
#      values = ["false"]
#    }
#  }
# }

# data "aws_iam_policy_document" "allow_acess_extension_launchpad_bucket-new" {
#   statement {
#     effect = "Deny"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }

#     actions = [
#       "s3:PutObject",
#     ]
#     not_resources = [
#       "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-new.id}/*.jpg",
#       "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-new.id}/*.jpeg",
#       "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-new.id}/*.png",
#       "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-new.id}/*.gif",
#       "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-new.id}/*.svg",
#       "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-new.id}/*.JPG",
#       "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-new.id}/*.JPEG",
#       "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-new.id}/*.PNG",
#       "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-new.id}/*.GIF",
#       "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-new.id}/*.SVG"
#     ]
#   }

#   statement {
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = local.cloudfront_oai-new
#     }

#     actions = [
#       "s3:GetObject",
#     ]
#     resources = [
#       "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-new.id}/*",
#       "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-new.id}"
#     ]
#   }
# }

# resource "aws_s3_bucket_ownership_controls" "launchpad_bucket-new" {
#   bucket = aws_s3_bucket.launchpad_bucket-new.id

#   rule {
#     object_ownership = "BucketOwnerEnforced"
#   }
# }

# ### collection ###

# resource "aws_s3_bucket" "collection_bucket-new" {
#   bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-collectio-new"

#   tags = {
#     Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-collection-new",
#     System                      = "marketplace",
#     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
#     SupportPlatformOwnerPrimary = "BithumMeta",
#     OperationLevel              = "2"
#   }  
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "collection_bucket-new" {
#   bucket = aws_s3_bucket.collection_bucket-new.bucket

#   rule {
#     bucket_key_enabled = false 

#   	apply_server_side_encryption_by_default {
#   		sse_algorithm = "AES256"
#   	}
# 	}
# }

# resource "aws_s3_bucket_public_access_block" "collection_bucket-new" {
#   bucket = aws_s3_bucket.collection_bucket-new.id

#   block_public_acls   = true
#   ignore_public_acls  = true
#   block_public_policy = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket_cors_configuration" "collection_bucket-new" {
#   bucket = aws_s3_bucket.collection_bucket-new.bucket

#   cors_rule {
#     allowed_headers = ["*"]
#     allowed_methods = ["GET", "POST"]
#     allowed_origins = ["*"]
#     expose_headers  = []
#   }
# }

# resource "aws_s3_bucket_policy" "collection_bucket-new" {
#   bucket = aws_s3_bucket.collection_bucket-new.id
#   policy = data.aws_iam_policy_document.collection_bucket-new_policy.json
# }

# data "aws_iam_policy_document" "collection_bucket-new_policy" {
#   source_policy_documents = [
#     data.aws_iam_policy_document.allow_acess_extension_collection_bucket-new.json,
#     data.aws_iam_policy_document.collection_bucket-new_s3_secure_transport.json,
#     data.aws_iam_policy_document.allow_acess_collection_bucket-new_from_unity.json
#   ]
# }

# data "aws_iam_policy_document" "collection_bucket-new_s3_secure_transport" {
#     statement {
#     effect = "Deny"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }
#     actions = [
#       "s3:*",
#     ]
#     resources = [
#     "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}/*",
#     "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}"

#     ]
    
#     condition {
#      test     = "Bool"
#      variable =  "aws:SecureTransport"
#      values = ["false"]
#    }
#  }
# }

# data "aws_iam_policy_document" "allow_acess_extension_collection_bucket-new" {
#   statement {
#     effect = "Deny"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }

#     actions = [
#       "s3:PutObject",
#     ]
#     not_resources = [
#       "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}/*.jpg",
#       "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}/*.jpeg",
#       "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}/*.png",
#       "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}/*.gif",
#       "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}/*.svg",
#       "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}/*.JPG",
#       "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}/*.JPEG",
#       "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}/*.PNG",
#       "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}/*.GIF",
#       "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}/*.SVG"      
#     ]
#   }

#   statement {
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = local.cloudfront_oai-new
#     }

#     actions = [
#       "s3:GetObject",
#     ]
#     resources = [
#       "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}/*",
#       "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}"
#     ]
#   }

#   statement {
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = ["arn:aws:iam::351894368755:role/lambda-edge-role"]
#     }

#     actions = [
#       "s3:GetObject",
#       "s3:PutObject"
#     ]
#     resources = [
#       "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}/*",
#       "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}"
#     ]
#   }
# }

# data "aws_iam_policy_document" "allow_acess_collection_bucket-new_from_unity" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = ["${var.unity_s3_role_name}"]
#     }

#     actions = [
#       "s3:GetObject"
#     ]
#     resources = [
#       "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}/*",
#       "arn:aws:s3:::${aws_s3_bucket.collection_bucket-new.id}"
#     ]
#   }
# }

# resource "aws_s3_bucket_ownership_controls" "collection_bucket-new" {
#   bucket = aws_s3_bucket.collection_bucket-new.id

#   rule {
#     object_ownership = "BucketOwnerEnforced"
#   }
# }

# ### creator ###

# # fe-creatoradmin
# resource "aws_s3_bucket" "fe-creator_bucket-new" {
#   bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-creator-new"

#   tags = {
#     Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-creator-new"
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "fe-creator_bucket-new" {
#   bucket = aws_s3_bucket.fe-creator_bucket-new.bucket

#   rule {
#     bucket_key_enabled = false 

#   	apply_server_side_encryption_by_default {
#   		sse_algorithm = "AES256"
#   	}
# 	}
# }

# resource "aws_s3_bucket_public_access_block" "fe-creator_bucket-new" {
#   bucket = aws_s3_bucket.fe-creator_bucket-new.id

#   block_public_acls   = true
#   ignore_public_acls  = true
#   block_public_policy = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket_policy" "fe-creator_bucket-new" {
#   bucket = aws_s3_bucket.fe-creator_bucket-new.id
#   policy = data.aws_iam_policy_document.fe-creator_bucket-new_policy.json
# }

# data "aws_iam_policy_document" "fe-creator_bucket-new_policy" {
#   source_policy_documents = [
#     data.aws_iam_policy_document.fe-creator_bucket-new.json,
#     data.aws_iam_policy_document.fe-creator_bucket-new_s3_secure_transport.json
#   ]
# }

# data "aws_iam_policy_document" "fe-creator_bucket-new_s3_secure_transport" {
#     statement {
#     effect = "Deny"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }
#     actions = [
#       "s3:*",
#     ]
#     resources = [
#     "arn:aws:s3:::${aws_s3_bucket.fe-creator_bucket-new.id}/*",
#     "arn:aws:s3:::${aws_s3_bucket.fe-creator_bucket-new.id}"

#     ]
    
#     condition {
#      test     = "Bool"
#      variable =  "aws:SecureTransport"
#      values = ["false"]
#    }
#  }
# }

# data "aws_iam_policy_document" "fe-creator_bucket-new" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.cloudfront_creatoradmin_oai_bc}"] ## 수정 해야함
#     }

#     actions = [
#       "s3:GetObject",
#     ]
#     resources = [
#       "arn:aws:s3:::${aws_s3_bucket.fe-creator_bucket-new.id}/*",
#       "arn:aws:s3:::${aws_s3_bucket.fe-creator_bucket-new.id}"
#     ]
#   }
# }

# resource "aws_s3_bucket_ownership_controls" "fe-creator_bucket-new" {
#   bucket = aws_s3_bucket.fe-creator_bucket-new.id

#   rule {
#     object_ownership = "BucketOwnerEnforced"
#   }
# }

# ### fe-systemadmin ### 

# resource "aws_s3_bucket" "fe-systemadmin_bucket-new" {
#   bucket = "s3-${var.aws_an2_shot_region}-${var.environment}-${var.service_name}-fe-systemadmin-new"

#   tags = {
#     Name = "s3-${var.aws_an2_shot_region}-${var.environment}-${var.service_name}-fe-systemadmin-new",
#     System                      = "systemadmin",
#     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
#     SupportPlatformOwnerPrimary = "BithumMeta",
#     OperationLevel              = "2"
#   }
#   provider = aws.an2
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "fe-systemadmin_bucket-new" {
#   bucket = aws_s3_bucket.fe-systemadmin_bucket-new.bucket

#   rule {
#     bucket_key_enabled = false 

#   	apply_server_side_encryption_by_default {
#   		sse_algorithm = "AES256"
#   	}
# 	}
#   provider = aws.an2
# }

# resource "aws_s3_bucket_public_access_block" "fe-systemadmin_bucket-new" {
#   bucket = aws_s3_bucket.fe-systemadmin_bucket-new.id

#   block_public_acls   = true
#   ignore_public_acls  = true
#   block_public_policy = true
#   restrict_public_buckets = true
#   provider = aws.an2
# }

# resource "aws_s3_bucket_policy" "fe-systemadmin_bucket-new" {
#   bucket = aws_s3_bucket.fe-systemadmin_bucket-new.id
#   policy = data.aws_iam_policy_document.fe-systemadmin_bucket-new_policy.json
#   provider = aws.an2
# }

# data "aws_iam_policy_document" "fe-systemadmin_bucket-new_policy" {
#   source_policy_documents = [
#     data.aws_iam_policy_document.fe-systemadmin_bucket-new.json,
#     data.aws_iam_policy_document.fe-systemadmin_bucket-new_s3_secure_transport.json
#   ]
# }

# data "aws_iam_policy_document" "fe-systemadmin_bucket-new_s3_secure_transport" {
#       statement {
#     effect = "Deny"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }
#     actions = [
#       "s3:*",
#     ]
#     resources = [
#     "arn:aws:s3:::${aws_s3_bucket.fe-systemadmin_bucket-new.id}/*",
#     "arn:aws:s3:::${aws_s3_bucket.fe-systemadmin_bucket-new.id}"

#     ]
    
#     condition {
#      test     = "Bool"
#      variable =  "aws:SecureTransport"
#      values = ["false"]
#    }
#  }

# }

# data "aws_iam_policy_document" "fe-systemadmin_bucket-new" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }

#     actions = [
#       "s3:GetObject",
#     ]
#     resources = [
#       "arn:aws:s3:::${aws_s3_bucket.fe-systemadmin_bucket-new.id}/*",
#       "arn:aws:s3:::${aws_s3_bucket.fe-systemadmin_bucket-new.id}"
#     ]

#     condition {
#       test     = "StringEquals"
#       variable = "aws:SourceVpce"

#       values = [ 
#         "vpce-0c798857e77754803"
#       ]
#     }
#   }
# }

# resource "aws_s3_bucket_ownership_controls" "fe-systemadmin_bucket-new" {
#   bucket = aws_s3_bucket.fe-systemadmin_bucket-new.id

#   rule {
#     object_ownership = "BucketOwnerEnforced"
#   }
#   provider = aws.an2
# }





