resource "aws_s3_bucket" "nft_bucket" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-nft"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-nft",
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
    data.template_file.nft_bucket_s3_secure_transport.rendered,
    # data.aws_iam_policy_document.allow_acess_nft_bucket_from_unity.json 
  ]
}

data "template_file" "nft_bucket_s3_secure_transport" {
  template = "${file("../../template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.nft_bucket.arn}"
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
      identifiers = var.environment == "dev" ? [
        "arn:aws:iam::351894368755:role/lambda-edge-role",
        "arn:aws:iam::${var.aws_account_number}:role/batch-ecs-excution-role-next"
      ] : [
        "arn:aws:iam::351894368755:role/lambda-edge-role",
        "arn:aws:iam::${var.aws_account_number}:role/batch-ecs-excution-role"
      ]
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

resource "aws_s3_bucket" "collection_bucket" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-collection"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-collection",
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "collection_bucket" {
  bucket = aws_s3_bucket.collection_bucket.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "collection_bucket" {
  bucket = aws_s3_bucket.collection_bucket.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "collection_bucket" {
  bucket = aws_s3_bucket.collection_bucket.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

resource "aws_s3_bucket_policy" "collection_bucket" {
  bucket = aws_s3_bucket.collection_bucket.id
  policy = data.aws_iam_policy_document.collection_bucket_policy.json
}

data "aws_iam_policy_document" "collection_bucket_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.allow_acess_extension_collection_bucket.json,
    data.template_file.collection_bucket_s3_secure_transport.rendered,
    data.aws_iam_policy_document.allow_acess_collection_bucket_from_unity.json
  ]
}

data "template_file" "collection_bucket_s3_secure_transport" {
  template = "${file("../../template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.collection_bucket.arn}"
  }
}

data "aws_iam_policy_document" "allow_acess_extension_collection_bucket" {
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
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket.id}/*.jpg",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket.id}/*.jpeg",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket.id}/*.png",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket.id}/*.gif",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket.id}/*.svg",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket.id}/*.JPG",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket.id}/*.JPEG",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket.id}/*.PNG",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket.id}/*.GIF",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket.id}/*.SVG"      
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
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket.id}"
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
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket.id}"
    ]
  }
}

data "aws_iam_policy_document" "allow_acess_collection_bucket_from_unity" {
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
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.collection_bucket.id}"
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "collection_bucket" {
  bucket = aws_s3_bucket.collection_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket" "launchpad_bucket" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-launchpad"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-launchpad",
    System                      = "launchpad",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "launchpad_bucket" {
  bucket = aws_s3_bucket.launchpad_bucket.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "launchpad_bucket" {
  bucket = aws_s3_bucket.launchpad_bucket.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "launchpad_bucket" {
  bucket = aws_s3_bucket.launchpad_bucket.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

resource "aws_s3_bucket_policy" "launchpad_bucket" {
  bucket = aws_s3_bucket.launchpad_bucket.id
  policy = data.aws_iam_policy_document.launchpad_bucket_policy.json
}

data "aws_iam_policy_document" "launchpad_bucket_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.allow_acess_extension_launchpad_bucket.json,
    data.template_file.launchpad_bucket_s3_secure_transport.rendered
  ]
}

data "template_file" "launchpad_bucket_s3_secure_transport" {
  template = "${file("../../template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.launchpad_bucket.arn}"
  }
}

data "aws_iam_policy_document" "allow_acess_extension_launchpad_bucket" {
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
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket.id}/*.jpg",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket.id}/*.jpeg",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket.id}/*.png",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket.id}/*.gif",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket.id}/*.svg",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket.id}/*.JPG",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket.id}/*.JPEG",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket.id}/*.PNG",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket.id}/*.GIF",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket.id}/*.SVG"
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
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket.id}"
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
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.launchpad_bucket.id}"
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "launchpad_bucket" {
  bucket = aws_s3_bucket.launchpad_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket" "portfolio_bucket" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-portfolio"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-portfolio",
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
    data.template_file.portfolio_bucket_s3_secure_transport.rendered
  ]
}

data "template_file" "portfolio_bucket_s3_secure_transport" {
  template = "${file("../../template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.portfolio_bucket.arn}"
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

resource "aws_s3_bucket" "member_bucket" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-member"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-member",
    System                      = "marketplace",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "2"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "member_bucket" {
  bucket = aws_s3_bucket.member_bucket.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "member_bucket" {
  bucket = aws_s3_bucket.member_bucket.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "member_bucket" {
  bucket = aws_s3_bucket.member_bucket.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

resource "aws_s3_bucket_policy" "member_bucket" {
  bucket = aws_s3_bucket.member_bucket.id
  policy = data.aws_iam_policy_document.member_bucket_policy.json
}

data "aws_iam_policy_document" "member_bucket_policy" {
  source_policy_documents = [
    data.aws_iam_policy_document.allow_acess_extension_member_bucket.json,
    data.template_file.member_bucket_s3_secure_transport.rendered,
    data.aws_iam_policy_document.allow_acess_member_bucket_from_unity.json
  ]
}

data "template_file" "member_bucket_s3_secure_transport" {
  template = "${file("../../template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.member_bucket.arn}"
  }
}

data "aws_iam_policy_document" "allow_acess_extension_member_bucket" {
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
      "arn:aws:s3:::${aws_s3_bucket.member_bucket.id}/*.jpg",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket.id}/*.jpeg",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket.id}/*.png",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket.id}/*.gif",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket.id}/*.svg",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket.id}/*.JPG",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket.id}/*.JPEG",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket.id}/*.PNG",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket.id}/*.GIF",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket.id}/*.SVG"
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
      "arn:aws:s3:::${aws_s3_bucket.member_bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket.id}"
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
      "arn:aws:s3:::${aws_s3_bucket.member_bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket.id}"
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
      "arn:aws:s3:::${aws_s3_bucket.member_bucket.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.member_bucket.id}"
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "member_bucket" {
  bucket = aws_s3_bucket.member_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket" "heap_dump_bucket" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-heap-dump"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-heap-dump",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "heap_dump_bucket" {
  bucket = aws_s3_bucket.heap_dump_bucket.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "heap_dump_bucket" {
  bucket = aws_s3_bucket.heap_dump_bucket.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "heap_dump_bucket" {
  bucket = aws_s3_bucket.heap_dump_bucket.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

resource "aws_s3_bucket_policy" "heap_dump_bucket" {
  bucket = aws_s3_bucket.heap_dump_bucket.id
  policy = data.aws_iam_policy_document.heap_dump_bucket_policy.json
}

data "aws_iam_policy_document" "heap_dump_bucket_policy" {
  source_policy_documents = [
    data.template_file.heap_dump_bucket_s3_secure_transport.rendered
  ]
}

data "template_file" "heap_dump_bucket_s3_secure_transport" {
  template = "${file("../../template/s3-secure-transport.json.tpl")}"

  vars = {
    resource = "${aws_s3_bucket.heap_dump_bucket.arn}"
  }
}

resource "aws_s3_bucket_ownership_controls" "heap_dump_bucket" {
  bucket = aws_s3_bucket.heap_dump_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}