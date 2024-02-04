locals {
  cloudfront_oai = var.environment == "dev" ? [
      "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.cloudfront_marketplace_oai}",
      "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.cloudfront_marketplace_next_oai}",
      "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E22H27EMTUEYZ9"] : ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.cloudfront_marketplace_oai}"]
}



resource "aws_s3_bucket" "nft_bucket" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-nft-bc"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-nft-bc",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "nft_bucket" {
  bucket = aws_s3_bucket.nft_bucket.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "nft_bucket" {
  bucket = aws_s3_bucket.nft_bucket.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "nft_bucket" {
  bucket = aws_s3_bucket.nft_bucket.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

resource "aws_s3_bucket_policy" "nft_bucket" {
  bucket = aws_s3_bucket.nft_bucket.id
  policy = data.aws_iam_policy_document.nft_bucket_policy.json
}

data "aws_iam_policy_document" "nft_bucket_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.allow_acess_extension_nft_bucket.json,
    data.aws_iam_policy_document.nft_bucket_s3_secure_transport.json,
    data.aws_iam_policy_document.allow_acess_nft_bucket_from_unity.json
  ]
}

data "aws_iam_policy_document" "nft_bucket_s3_secure_transport" {
    statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:*",
    ]
    resources = [
    "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*",
    "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}"

    ]
    
    condition {
     test     = "Bool"
     variable =  "aws:SecureTransport"
     values = ["false"]
   }
 }
}

data "aws_iam_policy_document" "allow_acess_extension_nft_bucket" {
  statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]
    not_resources = [
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.jpg",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.jpeg",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.png",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.gif",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.mp4",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.avi",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.mp3",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.mav",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.ogg",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.gltf",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.glb",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.zip",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.json",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.wav",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.svg",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.JPG",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.JPEG",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.PNG",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.GIF",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.MP4",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.AVI",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.MP3",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.MAV",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.OGG",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.GLTF",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.GLB",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.ZIP",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.JSON",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.WAV",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.SVG",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*.webp"
    ]
  }
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = local.cloudfront_oai
    }

    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}"
    ]
  }

  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::351894368755:role/lambda-edge-role",
      "arn:aws:iam::385866877617:role/marketplace_bottlerocket_node-eks-node-group" ]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}"
    ]
  }
}

data "aws_iam_policy_document" "allow_acess_nft_bucket_from_unity" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["${var.unity_s3_role_name}"]
    }

    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.nft_bucket.id}"
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "nft_bucket" {
  bucket = aws_s3_bucket.nft_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}


### 마켓 플레이스 bc s3 ## 

resource "aws_s3_bucket" "fe-marketplace-bc_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-marketplace-bc"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-marketplace-bc",
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fe-marketplace-bc_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = aws_s3_bucket.fe-marketplace-bc_bucket[0].bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "fe-marketplace-bc_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = aws_s3_bucket.fe-marketplace-bc_bucket[0].id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "fe-marketplace-bc_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = aws_s3_bucket.fe-marketplace-bc_bucket[0].id
  policy = data.aws_iam_policy_document.fe-marketplace-bc_bucket_policy[0].json
}

data "aws_iam_policy_document" "fe-marketplace-bc_bucket_policy" {
  count = var.environment == "dev" ? 1:0

  source_policy_documents = [
    data.aws_iam_policy_document.fe-marketplace-bc_bucket[0].json,
    data.aws_iam_policy_document.fe-marketplace-bc_bucket_s3_secure_transport[0].json ## 수정
  ]
}

data "aws_iam_policy_document" "fe-marketplace-bc_bucket_s3_secure_transport" {
  count = var.environment == "dev" ? 1:0
    statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:*",
    ]
    resources = [
    "arn:aws:s3:::${aws_s3_bucket.fe-marketplace-bc_bucket[0].id}/*",
    "arn:aws:s3:::${aws_s3_bucket.fe-marketplace-bc_bucket[0].id}"

    ]
    
    condition {
     test     = "Bool"
     variable =  "aws:SecureTransport"
     values = ["false"]
   }
 }
}



data "aws_iam_policy_document" "fe-marketplace-bc_bucket" {
  count = var.environment == "dev" ? 1:0

  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.marketplace_dev_bc.id}"]
    }

    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.fe-marketplace-bc_bucket[0].id}/*",
      "arn:aws:s3:::${aws_s3_bucket.fe-marketplace-bc_bucket[0].id}"
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "fe-marketplace-bc_bucket" {
  count = var.environment == "dev" ? 1:0

  bucket = aws_s3_bucket.fe-marketplace-bc_bucket[0].id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

### member bucket ### 

resource "aws_s3_bucket" "member_bucket-bc" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-member-bc"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-member-bc",
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "member_bucket-bc" {
  bucket = aws_s3_bucket.member_bucket-bc.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "member_bucket-bc" {
  bucket = aws_s3_bucket.member_bucket-bc.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "member_bucket-bc" {
  bucket = aws_s3_bucket.member_bucket-bc.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

resource "aws_s3_bucket_policy" "member_bucket-bc" {
  bucket = aws_s3_bucket.member_bucket-bc.id
  policy = data.aws_iam_policy_document.member_bucket_policy-bc.json
}

data "aws_iam_policy_document" "member_bucket_policy-bc" {
  source_policy_documents = [
    data.aws_iam_policy_document.allow_acess_extension_member_bucket-bc.json,
    data.aws_iam_policy_document.member_bucket_s3_secure_transport-bc.json,
    data.aws_iam_policy_document.allow_acess_member_bucket_from_unity.json
  ]
}

data "aws_iam_policy_document" "member_bucket_s3_secure_transport-bc" {
   statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:*",
    ]
    resources = [
    "arn:aws:s3:::${aws_s3_bucket.member_bucket-bc.id}/*",
    "arn:aws:s3:::${aws_s3_bucket.member_bucket-bc.id}"

    ]
    
    condition {
     test     = "Bool"
     variable =  "aws:SecureTransport"
     values = ["false"]
   }
 }
}

data "aws_iam_policy_document" "allow_acess_extension_member_bucket-bc" {
  statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]
    not_resources = [
      "arn:aws:s3:::${aws_s3_bucket.member_bucket-bc.id}/*.jpg",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket-bc.id}/*.jpeg",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket-bc.id}/*.png",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket-bc.id}/*.gif",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket-bc.id}/*.svg",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket-bc.id}/*.JPG",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket-bc.id}/*.JPEG",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket-bc.id}/*.PNG",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket-bc.id}/*.GIF",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket-bc.id}/*.SVG"
    ]
  }
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = local.cloudfront_oai
    }

    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.member_bucket-bc.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket-bc.id}"
    ]
  }

}

data "aws_iam_policy_document" "allow_acess_member_bucket_from_unity" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["${var.unity_s3_role_name}"]
    }

    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.member_bucket-bc.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket-bc.id}"
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "member_bucket-bc" {
  bucket = aws_s3_bucket.member_bucket-bc.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

### comm s3 

resource "aws_s3_bucket" "comm_bucket-bc" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-comm-bc"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-comm-bc",
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "comm_bucket-bc" {
  bucket = aws_s3_bucket.comm_bucket-bc.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "comm_bucket-bc" {
  bucket = aws_s3_bucket.comm_bucket-bc.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "comm_bucket-bc" {
  bucket = aws_s3_bucket.comm_bucket-bc.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

resource "aws_s3_bucket_policy" "comm_bucket-bc" {
  bucket = aws_s3_bucket.comm_bucket-bc.id
  policy = data.aws_iam_policy_document.comm_bucket_policy-bc.json
}

data "aws_iam_policy_document" "comm_bucket_policy-bc" {
  source_policy_documents = [
    data.aws_iam_policy_document.allow_acess_extension_comm_bucket-bc.json,
    data.aws_iam_policy_document.comm_bucket_s3_secure_transport-bc.json,
    data.aws_iam_policy_document.allow_acess_comm_bucket_from_unity.json
  ]
}

data "aws_iam_policy_document" "comm_bucket_s3_secure_transport-bc" {
   statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:*",
    ]
    resources = [
    "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}/*",
    "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}"

    ]
    
    condition {
     test     = "Bool"
     variable =  "aws:SecureTransport"
     values = ["false"]
   }
 }
}

data "aws_iam_policy_document" "allow_acess_extension_comm_bucket-bc" {
  statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]
    not_resources = [
      "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}/*.jpg",
      "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}/*.jpeg",
      "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}/*.png",
      "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}/*.gif",
      "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}/*.svg",
      "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}/*.JPG",
      "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}/*.JPEG",
      "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}/*.PNG",
      "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}/*.GIF",
      "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}/*.SVG"
    ]
  }
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = local.cloudfront_oai
    }

    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}"
    ]
  }
    statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::351894368755:role/lambda-edge-role"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}"
    ]
  }
}

data "aws_iam_policy_document" "allow_acess_comm_bucket_from_unity" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["${var.unity_s3_role_name}"]
    }

    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.comm_bucket-bc.id}"
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "comm_bucket-bc" {
  bucket = aws_s3_bucket.comm_bucket-bc.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

## launchpad ###

resource "aws_s3_bucket" "launchpad_bucket-bc" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-launchpad-bc"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-launchpad-bc",
    System                      = "launchpad",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "launchpad_bucket-bc" {
  bucket = aws_s3_bucket.launchpad_bucket-bc.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "launchpad_bucket-bc" {
  bucket = aws_s3_bucket.launchpad_bucket-bc.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "launchpad_bucket-bc" {
  bucket = aws_s3_bucket.launchpad_bucket-bc.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

resource "aws_s3_bucket_policy" "launchpad_bucket-bc" {
  bucket = aws_s3_bucket.launchpad_bucket-bc.id
  policy = data.aws_iam_policy_document.launchpad_bucket-bc_policy.json
}

data "aws_iam_policy_document" "launchpad_bucket-bc_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.allow_acess_extension_launchpad_bucket-bc.json,
    data.aws_iam_policy_document.launchpad_bucket-bc_s3_secure_transport.json
  ]
}

data "aws_iam_policy_document" "launchpad_bucket-bc_s3_secure_transport" {
    statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:*",
    ]
    resources = [
    "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-bc.id}/*",
    "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-bc.id}"

    ]
    
    condition {
     test     = "Bool"
     variable =  "aws:SecureTransport"
     values = ["false"]
   }
 }
}

data "aws_iam_policy_document" "allow_acess_extension_launchpad_bucket-bc" {
  statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]
    not_resources = [
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-bc.id}/*.jpg",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-bc.id}/*.jpeg",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-bc.id}/*.png",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-bc.id}/*.gif",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-bc.id}/*.svg",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-bc.id}/*.JPG",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-bc.id}/*.JPEG",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-bc.id}/*.PNG",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-bc.id}/*.GIF",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-bc.id}/*.SVG"
    ]
  }

  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = local.cloudfront_oai
    }

    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-bc.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket-bc.id}"
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "launchpad_bucket-bc" {
  bucket = aws_s3_bucket.launchpad_bucket-bc.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

### collection ###

resource "aws_s3_bucket" "collection_bucket-bc" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-collection-bc"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-collection-bc",
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "collection_bucket-bc" {
  bucket = aws_s3_bucket.collection_bucket-bc.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "collection_bucket-bc" {
  bucket = aws_s3_bucket.collection_bucket-bc.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "collection_bucket-bc" {
  bucket = aws_s3_bucket.collection_bucket-bc.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

resource "aws_s3_bucket_policy" "collection_bucket-bc" {
  bucket = aws_s3_bucket.collection_bucket-bc.id
  policy = data.aws_iam_policy_document.collection_bucket-bc_policy.json
}

data "aws_iam_policy_document" "collection_bucket-bc_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.allow_acess_extension_collection_bucket-bc.json,
    data.aws_iam_policy_document.collection_bucket-bc_s3_secure_transport.json,
    data.aws_iam_policy_document.allow_acess_collection_bucket-bc_from_unity.json
  ]
}

data "aws_iam_policy_document" "collection_bucket-bc_s3_secure_transport" {
    statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:*",
    ]
    resources = [
    "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}/*",
    "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}"

    ]
    
    condition {
     test     = "Bool"
     variable =  "aws:SecureTransport"
     values = ["false"]
   }
 }
}

data "aws_iam_policy_document" "allow_acess_extension_collection_bucket-bc" {
  statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]
    not_resources = [
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}/*.jpg",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}/*.jpeg",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}/*.png",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}/*.gif",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}/*.svg",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}/*.JPG",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}/*.JPEG",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}/*.PNG",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}/*.GIF",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}/*.SVG"      
    ]
  }

  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = local.cloudfront_oai
    }

    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}"
    ]
  }

  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::351894368755:role/lambda-edge-role"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}"
    ]
  }
}

data "aws_iam_policy_document" "allow_acess_collection_bucket-bc_from_unity" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["${var.unity_s3_role_name}"]
    }

    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket-bc.id}"
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "collection_bucket-bc" {
  bucket = aws_s3_bucket.collection_bucket-bc.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

### creator ###

# fe-creatoradmin
resource "aws_s3_bucket" "fe-creator_bucket-bc" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-creator-bc"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-fe-creator-bc"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fe-creator_bucket-bc" {
  bucket = aws_s3_bucket.fe-creator_bucket-bc.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "fe-creator_bucket-bc" {
  bucket = aws_s3_bucket.fe-creator_bucket-bc.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "fe-creator_bucket-bc" {
  bucket = aws_s3_bucket.fe-creator_bucket-bc.id
  policy = data.aws_iam_policy_document.fe-creator_bucket-bc_policy.json
}

data "aws_iam_policy_document" "fe-creator_bucket-bc_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.fe-creator_bucket-bc.json,
    data.aws_iam_policy_document.fe-creator_bucket-bc_s3_secure_transport.json
  ]
}

data "aws_iam_policy_document" "fe-creator_bucket-bc_s3_secure_transport" {
    statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:*",
    ]
    resources = [
    "arn:aws:s3:::${aws_s3_bucket.fe-creator_bucket-bc.id}/*",
    "arn:aws:s3:::${aws_s3_bucket.fe-creator_bucket-bc.id}"

    ]
    
    condition {
     test     = "Bool"
     variable =  "aws:SecureTransport"
     values = ["false"]
   }
 }
}

data "aws_iam_policy_document" "fe-creator_bucket-bc" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.creatoradmin_dev_bc.id}"] ## 수정 해야함
    }

    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.fe-creator_bucket-bc.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.fe-creator_bucket-bc.id}"
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "fe-creator_bucket-bc" {
  bucket = aws_s3_bucket.fe-creator_bucket-bc.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

### fe-systemadmin ### 

resource "aws_s3_bucket" "fe-systemadmin_bucket-bc" {
  bucket = "s3-${var.aws_an2_shot_region}-${var.environment}-${var.service_name}-fe-systemadmin-bc"

  tags = {
    Name = "s3-${var.aws_an2_shot_region}-${var.environment}-${var.service_name}-fe-systemadmin-bc",
    System                      = "systemadmin",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
  provider = aws.an2
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fe-systemadmin_bucket-bc" {
  bucket = aws_s3_bucket.fe-systemadmin_bucket-bc.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
  provider = aws.an2
}

resource "aws_s3_bucket_public_access_block" "fe-systemadmin_bucket-bc" {
  bucket = aws_s3_bucket.fe-systemadmin_bucket-bc.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
  provider = aws.an2
}

resource "aws_s3_bucket_policy" "fe-systemadmin_bucket-bc" {
  bucket = aws_s3_bucket.fe-systemadmin_bucket-bc.id
  policy = data.aws_iam_policy_document.fe-systemadmin_bucket-bc_policy.json
  provider = aws.an2
}

data "aws_iam_policy_document" "fe-systemadmin_bucket-bc_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.fe-systemadmin_bucket-bc.json,
    data.aws_iam_policy_document.fe-systemadmin_bucket-bc_s3_secure_transport.json
  ]
}

data "aws_iam_policy_document" "fe-systemadmin_bucket-bc_s3_secure_transport" {
      statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:*",
    ]
    resources = [
    "arn:aws:s3:::${aws_s3_bucket.fe-systemadmin_bucket-bc.id}/*",
    "arn:aws:s3:::${aws_s3_bucket.fe-systemadmin_bucket-bc.id}"

    ]
    
    condition {
     test     = "Bool"
     variable =  "aws:SecureTransport"
     values = ["false"]
   }
 }

}

data "aws_iam_policy_document" "fe-systemadmin_bucket-bc" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.fe-systemadmin_bucket-bc.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.fe-systemadmin_bucket-bc.id}"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceVpce"

      values = [ 
        "vpce-0c798857e77754803"
      ]
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "fe-systemadmin_bucket-bc" {
  bucket = aws_s3_bucket.fe-systemadmin_bucket-bc.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
  provider = aws.an2
}


### fe-centrallwallet ### 

resource "aws_s3_bucket" "fe-centralwallet_bucket-bc" {
  bucket = "s3-${var.aws_an2_shot_region}-${var.environment}-${var.service_name}-fe-centralwallet-bc"

  tags = {
    Name = "s3-${var.aws_an2_shot_region}-${var.environment}-${var.service_name}-fe-centralwallet-bc",
    System                      = "systemadmin",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }
  provider = aws.an2
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fe-centralwallet_bucket-bc" {
  bucket = aws_s3_bucket.fe-centralwallet_bucket-bc.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
  provider = aws.an2
}

resource "aws_s3_bucket_public_access_block" "fe-centrallwalet_bucket-bc" {
  bucket = aws_s3_bucket.fe-centralwallet_bucket-bc.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
  provider = aws.an2
}

resource "aws_s3_bucket_policy" "fe-centralwallet_bucket-bc" {
  bucket = aws_s3_bucket.fe-centralwallet_bucket-bc.id
  policy = data.aws_iam_policy_document.fe-centralwallet_bucket-bc_policy.json
  provider = aws.an2
}

data "aws_iam_policy_document" "fe-centralwallet_bucket-bc_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.fe-centralwallet_bucket-bc.json,
    data.aws_iam_policy_document.fe-centralwallet_bucket-bc_s3_secure_transport.json
  ]
}

data "aws_iam_policy_document" "fe-centralwallet_bucket-bc_s3_secure_transport" {
      statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:*",
    ]
    resources = [
    "arn:aws:s3:::${aws_s3_bucket.fe-centralwallet_bucket-bc.id}/*",
    "arn:aws:s3:::${aws_s3_bucket.fe-centralwallet_bucket-bc.id}"

    ]
    
    condition {
     test     = "Bool"
     variable =  "aws:SecureTransport"
     values = ["false"]
   }
 }

}

data "aws_iam_policy_document" "fe-centralwallet_bucket-bc" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.fe-centralwallet_bucket-bc.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.fe-centralwallet_bucket-bc.id}"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceVpce"

      values = [ 
        "vpce-0c798857e77754803"
      ]
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "fe-centralwallet_bucket-bc" {
  bucket = aws_s3_bucket.fe-centralwallet_bucket-bc.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
  provider = aws.an2
}


# portfolio 

resource "aws_s3_bucket" "portfolio_bucket" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-portfolio-bc"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-portfolio-bc",
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "portfolio_bucket" {
  bucket = aws_s3_bucket.portfolio_bucket.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "portfolio_bucket" {
  bucket = aws_s3_bucket.portfolio_bucket.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "portfolio_bucket" {
  bucket = aws_s3_bucket.portfolio_bucket.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

resource "aws_s3_bucket_policy" "portfolio_bucket" {
  bucket = aws_s3_bucket.portfolio_bucket.id
  policy = data.aws_iam_policy_document.portfolio_bucket_policy.json
}

data "aws_iam_policy_document" "portfolio_bucket_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.allow_acess_extension_portfolio_bucket.json,
    data.aws_iam_policy_document.portfolio_bucket_s3_secure_transport.json
  ]
}

data "aws_iam_policy_document" "portfolio_bucket_s3_secure_transport" {
  statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:*",
    ]
    resources = [
    "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*",
    "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}"

    ]
    
    condition {
     test     = "Bool"
     variable =  "aws:SecureTransport"
     values = ["false"]
   }
 }
}

data "aws_iam_policy_document" "allow_acess_extension_portfolio_bucket" {
  statement {
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]
    not_resources = [
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.jpg",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.jpeg",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.png",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.pdf",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.ppt",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.pptx",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.txt",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.doc",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.docx",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.JPG",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.JPEG",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.PNG",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.PDF",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.PPT",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.PPTX",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.TXT",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.DOC",
      "arn:aws:s3:::${aws_s3_bucket.portfolio_bucket.id}/*.DOCX"      
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "portfolio_bucket" {
  bucket = aws_s3_bucket.portfolio_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
