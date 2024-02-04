module "app_cluster" {
  source  = "./module-eks"
  # source  = "terraform-aws-modules/eks/aws"
  # version = "18.21.0"


  cluster_name    = "eks-${var.aws_shot_region}-${var.environment}-${var.service_name}"
  cluster_version =  contains(["dev","stg"], var.environment) ? "1.24" : "1.24"

  vpc_id     = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.network.outputs.cluster_subnets

  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true

  cluster_enabled_log_types              = var.environment == "dev" ? [] : ["audit", "authenticator", "api", "controllerManager", "scheduler"]
  cloudwatch_log_group_retention_in_days = var.log_group_retention

  cluster_encryption_config = [{
    #provider_key_arn = "${data.terraform_remote_state.comm.outputs.kms_ec2_arn}"
    provider_key_arn = "${data.terraform_remote_state.comm.outputs.kms_ec2_arn}"
    resources        = ["secrets"]
  }]

  create_iam_role          = true
  iam_role_name            = var.environment == "nprd" ? "eks-nprd-node-role" : "eks-node-role"
  iam_role_use_name_prefix = false
  iam_role_description     = "EKS managed node group role"
  iam_role_tags = {
    Name    = "iamr-${var.environment}-${var.service_name}-eks-node"
    Purpose = "Protector of the kubelet"
  }
  iam_role_additional_policies = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  ]

  cluster_security_group_additional_rules = {
    ingress_gitlab = {
      description = "To node 443 from gitlab"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      type        = "ingress"
      cidr_blocks = ["10.0.23.0/24"] # EKS 파게이트 형태 파드가 생성되서 빌드 되는 것이기 때문에 /24 대역대로 해야함 
    }

      ingress_vpn = {
      description = "Node vpn ingress"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      type        = "ingress"
      cidr_blocks = ["192.168.1.0/24"] # 회사 통합망에서 컨트롤 할 수 있게(cluster 에 접근해야 하기 때문)
    }

      ingress_k8s_manage = {
      description = "Manage To EKS"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      type        = "ingress"
      cidr_blocks = var.environment == "nprd" ? ["10.0.23.194/32"] : ["10.0.23.152/32" ] # EKS 워킹 서버 마다 다르기 때문에 분기 처리 필요 
    }
  }

  ## EKS CLuster 
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true # EKS 마스터와 노드 그룹간에 통신해야 하는 포트 오픈(SG-ID 로 오픈)
    }

    ingress_metric = {
      description                   = "Node metric ingress"
      protocol                      = "tcp"
      from_port                     = 4443
      to_port                       = 4443
      type                          = "ingress"
      source_cluster_security_group = true
    }

    ingress_an2_eks = {
      description = "Node Seoul EKS ingress"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      type        = "ingress"
      cidr_blocks = data.terraform_remote_state.network_an2.outputs.app_cidr_blocks
    }

    egress_gitlab = {
      description = "Node gitlb egress"
      protocol    = "-1"
      from_port   = 80
      to_port     = 80
      type        = "egress"
      cidr_blocks = ["10.0.23.0/24"]
    }

    egress_redis = {
      description = "Node redis egress"
      protocol    = "tcp"
      from_port   = 6379
      to_port     = 6379
      type        = "egress"
      cidr_blocks = data.terraform_remote_state.network.outputs.db_cidr_blocks
    }

    egress_mysql = {
      description = "Node aurora mysql egress"
      protocol    = "tcp"
      from_port   = 3306
      to_port     = 3306
      type        = "egress"
      cidr_blocks = data.terraform_remote_state.network.outputs.db_cidr_blocks
    }

    egress_lena_udp = {
      description = "Node lena egress"
      protocol    = "udp"
      from_port   = 16100
      to_port     = 16100
      type        = "egress"
      cidr_blocks = ["${data.terraform_remote_state.comm.outputs.lena_private_ip}/32"]
    }

    egress_lena_tcp = {
      description = "Node lena egress"
      protocol    = "tcp"
      from_port   = 16100
      to_port     = 16100
      type        = "egress"
      cidr_blocks = ["${data.terraform_remote_state.comm.outputs.lena_private_ip}/32"]
    }

    egress_tuna_tcp = {
      description = "Node tuna tcp egress"
      protocol    = "tcp"
      from_port   = 6100
      to_port     = 6100
      type        = "egress"
      cidr_blocks = ["${data.terraform_remote_state.comm.outputs.tuna_private_ip}/32"]
    }

    egress_tuna_udp = {
      description = "Node tuna udp egress"
      protocol    = "udp"
      from_port   = 6100
      to_port     = 6100
      type        = "egress"
      cidr_blocks = ["${data.terraform_remote_state.comm.outputs.tuna_private_ip}/32"]
    }

    egress_bcs_an2_tcp = {
      description = "Node bcs-an2 tcp egress"
      protocol    = "tcp"
      from_port   = 18080
      to_port     = 18080
      type        = "egress"
      cidr_blocks = data.terraform_remote_state.network_an2.outputs.app_cidr_blocks
    }

    egress_bcs_lb_an2_tcp = {
      description = "Node bcs-an2 tcp egress"
      protocol    = "tcp"
      from_port   = 18080
      to_port     = 18080
      type        = "egress"
      cidr_blocks = data.terraform_remote_state.network_an2.outputs.lb_cidr_blocks
    }

    egress_wallet_an2_tcp = {
      description = "Node wallet-eks-an2 tcp egress"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      type        = "egress"
      cidr_blocks = data.terraform_remote_state.network_an2.outputs.wallet_lb_cidr_blocks
    }

    egress_unity_kafka_tcp = {
      description = "Node unity kafka tcp egress"
      protocol    = "tcp"
      from_port   = 9092
      to_port     = 9092
      type        = "egress"
      cidr_blocks = ["10.1.96.0/19","10.1.128.0/19","10.1.160.0/19"]
    }
      egress_efs_tcp = {
      description = "Node efs tcp egress"
      protocol    = "tcp"
      from_port   = 2049
      to_port     = 2049
      type        = "egress"
      source_security_group_id = aws_security_group.efs_sg.id
    }

    ### temp ####
    egress_test_kafka_tcp = {
      description = "Node test kafka tcp egress"
      protocol    = "tcp"
      from_port   = 9092
      to_port     = 9092
      type        = "egress"
      cidr_blocks = data.terraform_remote_state.network.outputs.app_cidr_blocks
    }

    egress_all = {
      description = "Node all egress"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      self        = true
    }
  }

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type   = "AL2_x86_64"
    subnet_ids = data.terraform_remote_state.network.outputs.app_subnets
    instance_types = var.eks_node_instance_types
  #   iam_role_additional_policies = [
  #   "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  #   "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
  #   "${module.app_cluster.cluster_encryption}",
  #   "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  # ]
    # vpc_security_group_ids = [aws_security_group.additional_http.id, aws_security_group.additional_https.id]
  }

  eks_managed_node_groups = {
    ## manage worker node 
    management_bottlerocket_node = {
      create = true
      cluster_version =  contains(["dev","stg"], var.environment) ? "1.24" : "1.23"
      force_update_version = var.environment == "nprd" ? false : false
      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = var.management_bottlerocket_node.min_size
      max_size     = var.management_bottlerocket_node.max_size
      desired_size = var.management_bottlerocket_node.min_size

      instance_types = try(var.management_bottlerocket_node.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type

      create_iam_role = var.environment == "nprd" ? false : true
      iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/management_bottlerocket_node-eks-node-group"
      
      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "management"
      EOT

      tags = {
        System                      = "common",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "3"
      }   
    }

      management_bottlerocket_node_v2 = {
      create = true
      cluster_version =  contains(["dev","stg"], var.environment) ? "1.24" : "1.24"
      force_update_version = var.environment == "nprd" ? false : false
      iam_role_additional_policies = [
        "${module.app_cluster.cluster_encryption}", 
        "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
        "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        ]
      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = var.management_bottlerocket_node_v2.min_size
      max_size     = var.management_bottlerocket_node_v2.max_size
      desired_size = var.management_bottlerocket_node_v2.min_size

      instance_types = try(var.management_bottlerocket_node_v2.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type

      create_iam_role = var.environment == "nprd" ? false : true
      iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/management_bottlerocket_node-eks-node-group"
      
      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "management"
      EOT

      tags = {
        System                      = "common",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "3"
      }   
    }

    
    ## marketplace worker node 
    marketplace_bottlerocket_node = {
      create = true
      cluster_version =  contains(["dev","stg"], var.environment) ? "1.24" : "1.23"
      force_update_version = var.environment == "nprd" ? false : false
      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"
      min_size     = var.marketplace_bottlerocket_node.min_size
      max_size     = var.marketplace_bottlerocket_node.max_size
      desired_size = var.marketplace_bottlerocket_node.min_size

      instance_types = try(var.marketplace_bottlerocket_node.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type

      create_iam_role = var.environment == "nprd" ? false : true
      iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/marketplace_bottlerocket_node-eks-node-group"

      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "marketplace"
      EOT   

      tags = {
        System                      = "marketplace",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "2"
      } 
    }
    #   marketplace_bottlerocket_node_v2 = {
    #   create = true
    #   cluster_version =  contains(["dev","stg"], var.environment) ? "1.24" : "1.24"
    #   force_update_version = var.environment == "nprd" ? false : false # 기본 롤링 / 강제 종료 업데이트
    #   iam_role_additional_policies = [
    #     "${module.app_cluster.cluster_encryption}", 
    #     "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
    #     "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
    #     ]
    #   ami_type = "BOTTLEROCKET_x86_64"
    #   platform = "bottlerocket"

    #   min_size     = try(var.marketplace_bottlerocket_node_v2.min_size,0)
    #   max_size     = try(var.marketplace_bottlerocket_node_v2.max_size,0)
    #   desired_size = try(var.marketplace_bottlerocket_node_v2.min_size,0)
    #   instance_types = try(var.marketplace_bottlerocket_node_v2.instance_types, var.eks_node_instance_types)
    #   capacity_type  = var.capacity_type

    #   create_iam_role = var.environment == "nprd" ? false : true
    #   iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/marketplace_bottlerocket_node-eks-node-group"

    #   iam_role_use_name_prefix   = false
    #   enable_bootstrap_user_data = true

    #   bootstrap_extra_args = <<-EOT
    #   [settings.kernel]
    #   lockdown = "integrity"

    #   [settings.kubernetes.node-labels]
    #   "System" = "marketplace"
    #   EOT   

    #   tags = {
    #     System                      = "marketplace",
    #     BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    #     SupportPlatformOwnerPrimary = "BithumMeta",
    #     OperationLevel              = "2"
    #   } 
    # }

    feature_bottlerocket_node = {
      create = var.environment == "dev" ? true : false
      cluster_version = "1.24"
      force_update_version = var.environment == "nprd" ? false : false
      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = try(var.feature_bottlerocket_node.min_size, 0)
      max_size     = try(var.feature_bottlerocket_node.max_size, 0)
      desired_size = try(var.feature_bottlerocket_node.min_size, 0)

      instance_types = try(var.feature_bottlerocket_node.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type

      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "feature"
      EOT   

      tags = {
        System                      = "marketplace",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "2"
      } 
    }

    ## launchpad worker node 
    launchpad_bottlerocket_node = {
      create = var.environment == "dev" ? false : true 
      cluster_version =  contains(["dev","stg"], var.environment) ? "1.24" : "1.23"
      force_update_version = var.environment == "nprd" ? false : false

      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = try(var.launchpad_bottlerocket_node.min_size, 0)
      max_size     = try(var.launchpad_bottlerocket_node.max_size, 0)
      desired_size = try(var.launchpad_bottlerocket_node.min_size, 0)

      instance_types = try(var.launchpad_bottlerocket_node.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type

      create_iam_role = var.environment == "nprd" ? false : true
      iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/launchpad_bottlerocket_node-eks-node-group"

      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "launchpad"
      EOT   

      tags = {
        System                      = "launchpad",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "2"
      } 
    }
    
      launchpad_bottlerocket_node_v2 = {
      create = var.environment == "dev" ? false : true
      cluster_version =  contains(["dev","stg"], var.environment) ? "1.24" : "1.24"
      force_update_version = var.environment == "nprd" ? false : false
      iam_role_additional_policies = [
        "${module.app_cluster.cluster_encryption}", 
        "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
        "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        ]

      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = try(var.launchpad_bottlerocket_node_v2.min_size, 0)
      max_size     = try(var.launchpad_bottlerocket_node_v2.max_size, 0)
      desired_size = try(var.launchpad_bottlerocket_node_v2.min_size, 0)

      instance_types = try(var.launchpad_bottlerocket_node_v2.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type

      create_iam_role = var.environment == "nprd" ? false : true
      iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/launchpad_bottlerocket_node-eks-node-group"

      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "launchpad"
      EOT   

      tags = {
        System                      = "launchpad",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "2"
      } 
    }
 ## prd worker ea 0 
 ## 사용 하지 않음 
    metaverse_bottlerocket_node = {
      create = var.environment == "dev" ? false : true
      cluster_version =  contains(["dev","stg"], var.environment) ? "1.24" : "1.24"
      force_update_version = var.environment == "nprd" ? false : false

      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = try(var.metaverse_bottlerocket_node.min_size, 0)
      max_size     = try(var.metaverse_bottlerocket_node.max_size, 0)
      desired_size = try(var.metaverse_bottlerocket_node.min_size, 0)

      instance_types = try(var.metaverse_bottlerocket_node.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type

      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "metaverse"
      EOT   

      tags = {
        System                      = "metaverse",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "2"
      } 
    }
  ## middleware worker node 
    middleware_bottlerocket_node = {
      cluster_version =  contains(["dev","stg"], var.environment) ? "1.24" : "1.23"
      force_update_version = var.environment == "nprd" ? false : true
      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = try(var.middleware_bottlerocket_node.min_size, 0)
      max_size     = try(var.middleware_bottlerocket_node.max_size, 0)
      desired_size = try(var.middleware_bottlerocket_node.min_size, 0)

      instance_types = try(var.middleware_bottlerocket_node.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type

      create_iam_role = var.environment == "nprd" ? false : true
      iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/middleware_bottlerocket_node-eks-node-group"

      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "middleware"
      EOT  

      tags = {
        System                      = "bcs",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "2"
      }  
    }

      middleware_bottlerocket_node_v2 = {
      cluster_version =  contains(["dev","stg"], var.environment) ? "1.24" : "1.24"
      force_update_version = var.environment == "nprd" ? false : true
      iam_role_additional_policies = [
        "${module.app_cluster.cluster_encryption}", 
        "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
        "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        ]
      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = try(var.middleware_bottlerocket_node_v2.min_size, 0)
      max_size     = try(var.middleware_bottlerocket_node_v2.max_size, 0)
      desired_size = try(var.middleware_bottlerocket_node_v2.min_size, 0)

      instance_types = try(var.middleware_bottlerocket_node_v2.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type

      create_iam_role = var.environment == "nprd" ? false : true
      iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/middleware_bottlerocket_node-eks-node-group"

      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "middleware"
      EOT  

      tags = {
        System                      = "bcs",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "2"
      }  
    }
  ## common worker node 
      common_bottlerocket_node = {
      create = var.environment == "dev" ? false : true
      cluster_version =  contains(["dev","stg"], var.environment) ? "1.24" : "1.23"
      force_update_version = var.environment == "nprd" ? false : false

      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = try(var.common_bottlerocket_node.min_size, 0)
      max_size     = try(var.common_bottlerocket_node.max_size, 0)
      desired_size = try(var.common_bottlerocket_node.min_size, 0)

      instance_types = try(var.common_bottlerocket_node.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type

      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "common"
      EOT   

      tags = {
        System                      = "marketplace",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "2"
      } 
    }
      common_bottlerocket_node_v2 =  {
      create = var.environment == "dev" ? false : true
      cluster_version =  contains(["dev","stg"], var.environment) ? "1.24" : "1.24"
      force_update_version = var.environment == "nprd" ? false : false
      iam_role_additional_policies = [
        "${module.app_cluster.cluster_encryption}", 
        "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
        "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        ]
      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = try(var.common_bottlerocket_node_v2.min_size, 0)
      max_size     = try(var.common_bottlerocket_node_v2.max_size, 0)
      desired_size = try(var.common_bottlerocket_node_v2.min_size, 0)

      instance_types = try(var.common_bottlerocket_node_v2.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type

      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "common"
      EOT   

      tags = {
        System                      = "marketplace",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "2"
      } 
    } 
     # batch worker node 
      batch_bottlerocket_node =  {
      create = var.environment == "dev" ? false : true 
      cluster_version =  contains(["dev","stg"], var.environment) ? "1.24" : "1.23"
      force_update_version = var.environment == "nprd" ? false : false

      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = try(var.batch_bottlerocket_node.min_size, 0)
      max_size     = try(var.batch_bottlerocket_node.max_size, 0)
      desired_size = try(var.batch_bottlerocket_node.min_size, 0)

      instance_types = try(var.batch_bottlerocket_node.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type

      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "batch"
      EOT   

      tags = {
        System                      = "batch",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "2"
      } 
    } 

      batch_bottlerocket_node_v2 =  {
      create = var.environment == "dev" ? false : true
      cluster_version =  contains(["dev","stg"], var.environment) ? "1.24" : "1.24"
      force_update_version = var.environment == "nprd" ? false : false
      iam_role_additional_policies = [
        "${module.app_cluster.cluster_encryption}", 
        "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
        "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        ]
      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = try(var.batch_bottlerocket_node_v2.min_size, 0)
      max_size     = try(var.batch_bottlerocket_node_v2.max_size, 0)
      desired_size = try(var.batch_bottlerocket_node_v2.min_size, 0)

      instance_types = try(var.batch_bottlerocket_node_v2.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type

      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "batch"
      EOT   

      tags = {
        System                      = "batch",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "2"
      } 
    } 
  
  
  }

  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/Admin-AccountAccessRole"
      username = "Admin-AccountAccessRole"
      groups   = ["system:masters"]
      }, {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.environment}-gitlab-role"
      username = "${var.environment}-gitlab-role"
      groups   = ["system:masters"]
    }, {rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/EKSWorking-AssumeRole"
      username = "EKSWorking-AssumeRole"
      groups   = ["system:masters"]
    }
  ]

  tags = {
    Name                                                                                          = "eks-${var.aws_shot_region}-${var.environment}-${var.service_name}"
    "k8s.io/cluster-autoscaler/enabled"                                                           = 1
    "k8s.io/cluster-autoscaler/eks-${var.aws_shot_region}-${var.environment}-${var.service_name}" = 1
    System                      = "common"
    BusinessOwnerPrimary        = "infra@bithumbmeta.io"
    SupportPlatformOwnerPrimary = "BithumMeta"
    OperationLevel              = "3"
  }
}
