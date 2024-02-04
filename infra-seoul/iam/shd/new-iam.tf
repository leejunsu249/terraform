
############### common ############################

locals {
  mfa = (file("./mfa-policy.json"))
}

############### common confgure #########################

resource "aws_iam_policy" "policy_common_mfa" {
  name        = "policy-common-mfa"
  path        = "/"
  description = "for policy_common_mfa"
  policy = local.mfa
}

data "aws_iam_policy_document" "all-deny-ip" {
 statement {
   sid = ""
   effect = "Deny"
   actions = [
     "*",
   ]	
   resources = [
     "*"
   ]
   condition {
     test     = "NotIpAddress"
     variable = "aws:SourceIp"
     values = [
   	 "211.36.236.126",
      "211.40.58.126"
     ]
   }
    condition {
     test     = "Bool"
     variable = "aws:ViaAWSService"
     values = [false]
   }
 }
}

resource "aws_iam_policy" "policy_common_deny_ip" {
  name        = "policy-all-deny-ip"
  path        = "/"
  description = "for policy_common_deny_ip"
  policy = data.aws_iam_policy_document.all-deny-ip.json
}
############### developer user #########################


module "dev_users" {
  source        = "../module/iam/modules/iam-user/"
  for_each      = toset(var.dev_user_names)
  name          = [each.key]
  pgp_key       = "keybase:lhb0209"
  path          = "/"
  force_destroy = true 
  ## default true
  password_reset_required = true 
}

resource "aws_iam_policy" "policy_assume_develop" {
  name        = "policy-sts-develop"
  path        = "/"
  description = "for policy-sts-develop"
    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
      Resource = [
          "arn:aws:iam::908317417455:role/Developer-AccountAccessRole",
          "arn:aws:iam::385866877617:role/Developer-AccountAccessRole",
          "arn:aws:iam::087942668956:role/Developer-AccountAccessRole",
          "arn:aws:iam::351894368755:role/role-net-Dev"
        ]
      },
    ]
  })
}



############### developer custom policy #########################
# sample 
data "aws_iam_policy_document" "dev_custom_policy" {
  statement {
    sid = "1"
    actions = [
      "*",
    ]
    resources = ["*"]
  }
}


module "dev_group" {
  source        = "../module/iam/modules/iam-group-with-policies/"
  name          = "bmeta-developer"
  group_users = var.dev_group_user

    custom_group_policy_arns = [
     aws_iam_policy.policy_assume_develop.arn,
     aws_iam_policy.policy_common_mfa.arn,
     aws_iam_policy.policy_common_deny_ip.arn,
     "arn:aws:iam::aws:policy/AWSLambda_FullAccess",
  ]

  #   custom_group_policies = [
  #   {
  #     name   = "policy-all-deny-ip" # 커스텀 policy 이름
  #     policy = data.aws_iam_policy_document.all-deny-ip.json
  #   },
  # ]

  depends_on = [
    module.dev_users,
    aws_iam_policy.policy_assume_develop
  ]
}





############### infra user ############################

module "infra_users" {
  source        = "../module/iam/modules/iam-user/"
  for_each      ={ for k, v in toset(var.infra_user_names): k => v if var.infra_enabled }
  name          = [each.key]
  pgp_key       = "keybase:lhb0209"
  path          = "/"
  force_destroy = true 
  ## default true
  password_reset_required = true 
}


resource "aws_iam_policy" "policy_assume_infra" {
  name        = "policy-sts-infra"
  path        = "/"
  description = "for policy-sts-infra"
    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
      Resource = [
          "arn:aws:iam::908317417455:role/Admin-AccountAccessRole",
          "arn:aws:iam::385866877617:role/Admin-AccountAccessRole",
          "arn:aws:iam::351894368755:role/Admin-AccountAccessRole",
          "arn:aws:iam::087942668956:role/Admin-AccountAccessRole",
          "arn:aws:iam::385866877617:role/EKSWorking-AssumeRole",
          "arn:aws:iam::087942668956:role/EKSWorking-AssumeRole",
          "arn:aws:iam::908317417455:role/EKSWorking-AssumeRole",
          "arn:aws:iam::676826599814:role/EKSWorking-AssumeRole"
        ]
      },
    ]
  })
}

module "infra_group" {
  source        = "../module/iam/modules/iam-group-with-policies/"
  #count = length(var.dev_user_names)
  name          = "bmeta-infra"
  #group_users = ["${element(var.dev_user_names, count.index)}"]
  group_users = var.infra_group_user

   custom_group_policy_arns = [
    aws_iam_policy.policy_common_mfa.arn,
    aws_iam_policy.policy_assume_infra.arn,
    aws_iam_policy.policy_common_deny_ip.arn,
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]

  #   custom_group_policies = [
  #   {
  #     name   = "AllowS3Listing"
  #     policy = data.aws_iam_policy_document.sample.json
  #   },
  # ]

  depends_on = [
    #module.infra_users,
    aws_iam_policy.policy_assume_infra
  ]
}

# # ############### sc user ############################

module "secu_users" {
  source        = "../module/iam/modules/iam-user/"
  for_each      = { for k, v in toset(var.secu_user_names): k => v if var.secu_enabled }
  name          = [each.key]
  pgp_key       = "keybase:lhb0209"
  path          = "/"
  force_destroy = true 
  ## default true
  password_reset_required = true 
}


resource "aws_iam_policy" "policy_assume_secu" {
  name        = "policy-sts-secu"
  path        = "/"
  description = "for policy-sts-secu"
    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
      Resource = [
          "arn:aws:iam::908317417455:role/Security-AccountAccessRole",
          "arn:aws:iam::385866877617:role/Security-AccountAccessRole",
          "arn:aws:iam::351894368755:role/Security-AccountAccessRole",
          "arn:aws:iam::087942668956:role/Security-AccountAccessRole",
        ]
      },
    ]
  })
}

module "secu_group" {
  # count         = var.secu_enabled ? 1: 0
  source        = "../module/iam/modules/iam-group-with-policies/"
  #count = length(var.dev_user_names)
  name          = "bmeta-security"
  group_users = var.secu_group_user

    custom_group_policy_arns = [
     aws_iam_policy.policy_common_mfa.arn,
     aws_iam_policy.policy_assume_secu.arn,
     aws_iam_policy.policy_common_deny_ip.arn,
     "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess",
     "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
     "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
     "arn:aws:iam::aws:policy/AWSCloudTrail_ReadOnlyAccess",
     "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
     "arn:aws:iam::aws:policy/IAMReadOnlyAccess",

  ]

  #   custom_group_policies = [
  #   {
  #     name   = "AllowS3Listing"
  #     policy = data.aws_iam_policy_document.sample.json
  #   },
  # ]

  depends_on = [
    #module.secu_users
    aws_iam_policy.policy_assume_secu
  ]
}



# # ############### qa user ############################

module "qa_users" {
  source        = "../module/iam/modules/iam-user/"
  for_each      = { for k, v in toset(var.qa_user_names): k => v if var.qa_enabled }
  name          = [each.key]
  pgp_key       = "keybase:lhb0209"
  path          = "/"
  force_destroy = true 
  ## default true
  password_reset_required = true 
}


resource "aws_iam_policy" "policy_assume_qa" {
  name        = "policy-sts-qa"
  path        = "/"
  description = "for policy-sts-qa"
    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
      Resource = [
          "arn:aws:iam::385866877617:role/role-dev-QA",
          "arn:aws:iam::087942668956:role/role-stg-QA",
          "arn:aws:iam::908317417455:role/role-prd-QA"
        ]
      },
    ]
  })
}

module "qa_group" {
  # count         = var.qa_enabled ? 1: 0
  source        = "../module/iam/modules/iam-group-with-policies/"
  #count = length(var.dev_user_names)
  name          = "bmeta-qa"
  group_users = var.qa_group_user

    custom_group_policy_arns = [
     aws_iam_policy.policy_common_mfa.arn,  
     aws_iam_policy.policy_assume_qa.arn,
     aws_iam_policy.policy_common_deny_ip.arn,
  ]

  #   custom_group_policies = [
  #   {
  #     name   = "AllowS3Listing"
  #     policy = data.aws_iam_policy_document.sample.json
  #   },
  # ]

  depends_on = [
    #module.qa_users
    aws_iam_policy.policy_assume_secu
  ]
}

###### temp architectures ####

resource "aws_iam_policy" "policy_assume_architect" {
  name        = "policy-sts-architect"
  path        = "/"
  description = "for policy-sts-architect"
    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
      Resource = [
          "arn:aws:iam::908317417455:role/Architecture-AccountAccessRole",
          "arn:aws:iam::385866877617:role/Architecture-AccountAccessRole",
          "arn:aws:iam::351894368755:role/Architecture-AccountAccessRole",
          "arn:aws:iam::087942668956:role/Architecture-AccountAccessRole"
        ]
      },
    ]
  })
}

module "architect_group" {
  # count         = var.qa_enabled ? 1: 0
  source        = "../module/iam/modules/iam-group-with-policies/"
  #count = length(var.dev_user_names)
  name          = "bmeta-architect"
  group_users = var.architect_group_user

    custom_group_policy_arns = [
     aws_iam_policy.policy_common_mfa.arn,  
     aws_iam_policy.policy_assume_architect.arn,
     aws_iam_policy.policy_common_deny_ip.arn,
  ]

  #   custom_group_policies = [
  #   {
  #     name   = "AllowS3Listing"
  #     policy = data.aws_iam_policy_document.sample.json
  #   },
  # ]

  depends_on = [
    #module.qa_users
    aws_iam_policy.policy_assume_architect
  ]
}
