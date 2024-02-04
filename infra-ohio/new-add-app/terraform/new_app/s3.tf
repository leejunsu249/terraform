
resource "aws_s3_bucket" "holder_verify" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-holder-verify"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-holder-verify",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "holder_verify" {
  bucket = aws_s3_bucket.holder_verify.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "holder_verify" {
  bucket = aws_s3_bucket.holder_verify.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_cors_configuration" "holder_verify" {
  bucket = aws_s3_bucket.holder_verify.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

data "aws_iam_policy_document" "allow_acess_extension_holder_verify" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.holder_oid}"]
    }

    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.holder_verify.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.holder_verify.id}"
    ]
  }

}

resource "aws_s3_bucket_policy" "holder_verify" {
  bucket = aws_s3_bucket.holder_verify.id
  policy = data.aws_iam_policy_document.allow_acess_extension_holder_verify.json
}

##########
#s3 board
##########
resource "aws_s3_bucket" "board" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-board"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-board",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "board" {
  bucket = aws_s3_bucket.board.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "board" {
  bucket = aws_s3_bucket.board.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_cors_configuration" "board" {
  bucket = aws_s3_bucket.board.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

data "aws_iam_policy_document" "allow_acess_extension_board" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.front_oid}",
                     "arn:aws:iam::${var.aws_account_number}:role/be-marketplace-role",
                     "arn:aws:iam::351894368755:role/lambda-edge-role"]
    }

    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.board.id}"
    ]
  }

}

data "aws_iam_policy_document" "allow_acess_extension_board_bucket" {
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
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.jpg",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.jpeg",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.png",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.gif",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.mp4",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.avi",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.mp3",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.mav",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.ogg",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.gltf",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.glb",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.zip",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.json",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.wav",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.svg",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.JPG",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.JPEG",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.PNG",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.GIF",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.MP4",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.AVI",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.MP3",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.MAV",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.OGG",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.GLTF",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.GLB",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.ZIP",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.JSON",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.WAV",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.SVG",
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*.webp"
    ]
  }
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [ "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.front_oid}",
                       "arn:aws:iam::${var.aws_account_number}:role/be-marketplace-role"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject"      
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.board.id}"
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
      "arn:aws:s3:::${aws_s3_bucket.board.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.board.id}"
    ]
  }
}

resource "aws_s3_bucket_policy" "board" {
  bucket = aws_s3_bucket.board.id
  policy = data.aws_iam_policy_document.allow_acess_extension_board_bucket.json
}

######
#poll
######
resource "aws_s3_bucket" "poll" {
  bucket = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-poll"

  tags = {
    Name = "s3-${var.aws_shot_region}-${var.environment}-${var.service_name}-poll",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "poll" {
  bucket = aws_s3_bucket.poll.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
}

resource "aws_s3_bucket_public_access_block" "poll" {
  bucket = aws_s3_bucket.poll.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_cors_configuration" "poll" {
  bucket = aws_s3_bucket.poll.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}

data "aws_iam_policy_document" "allow_acess_extension_poll_bucket" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${var.front_oid}",
                    "arn:aws:iam::${var.aws_account_number}:role/be-systemadmin-role",
                    "arn:aws:iam::${var.aws_account_number}:role/be-poll-community-role"]
    }

    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.poll.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.poll.id}"
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
      "arn:aws:s3:::${aws_s3_bucket.poll.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.poll.id}"
    ]    

  }

}

resource "aws_s3_bucket_policy" "poll" {
  bucket = aws_s3_bucket.poll.id
  policy = data.aws_iam_policy_document.allow_acess_extension_poll_bucket.json
}


#### centralwallet-log s3 
resource "aws_s3_bucket" "central_log" {
  bucket = "s3-${var.aws_an2_shot_region}-${var.environment}-${var.service_name}-centralwallet-log"

  tags = {
    Name = "s3-${var.aws_an2_shot_region}-${var.environment}-${var.service_name}-centralwallet-log",
    System                      = "common",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "3"
  }
  provider = aws.an2
}

resource "aws_s3_bucket_server_side_encryption_configuration" "central_log" {
  bucket = aws_s3_bucket.central_log.bucket

  rule {
    bucket_key_enabled = false 

  	apply_server_side_encryption_by_default {
  		sse_algorithm = "AES256"
  	}
	}
  provider = aws.an2
}

resource "aws_s3_bucket_public_access_block" "central_log" {
  bucket = aws_s3_bucket.central_log.id

  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
  provider = aws.an2
}


resource "aws_s3_bucket_cors_configuration" "central_log" {
  bucket = aws_s3_bucket.central_log.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
  provider = aws.an2
}

data "aws_iam_policy_document" "allow_acess_extension_central_log" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.aws_account_number}:role/be-centralwallet-role"]
    }

    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.central_log.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.central_log.id}"
    ]
  
  }
  provider = aws.an2

}

resource "aws_s3_bucket_policy" "central_log" {
  bucket = aws_s3_bucket.central_log.id
  policy = data.aws_iam_policy_document.allow_acess_extension_central_log.json
  provider = aws.an2
}