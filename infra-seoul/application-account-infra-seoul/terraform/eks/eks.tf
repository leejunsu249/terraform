module "app_cluster" {
  source  = "./module-eks"
  # source  = "terraform-aws-modules/eks/aws"
  # version = "18.26.6"

  cluster_name    = "eks-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}"
  cluster_version = "1.24"

  vpc_id     = data.terraform_remote_state.network.outputs.wallet_vpc_id
  subnet_ids = data.terraform_remote_state.network.outputs.wallet_cluster_subnets

  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true

  cluster_enabled_log_types              = var.environment == "dev" ? [] : ["audit", "authenticator", "api", "controllerManager", "scheduler"]
  cloudwatch_log_group_retention_in_days = var.log_group_retention

  cluster_encryption_config = [{
    provider_key_arn = "${data.terraform_remote_state.comm.outputs.kms_ec2_arn}"
    resources        = ["secrets"]
  }]

  create_iam_role = false
  iam_role_arn    = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/eks-node-role"

  cluster_security_group_additional_rules = {
    ingress_gitlab = {
      description = "To node 443 from gitlab"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      type        = "ingress"
      cidr_blocks = ["10.0.23.0/24"]
    }

    ingress_argo = {
      description = "To node 443 from argo"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      type        = "ingress"
      cidr_blocks = data.terraform_remote_state.network_ue2.outputs.app_cidr_blocks
    }

    # ingress_shd_dev_wallet = {
    #   description = "from ec2-an2-shd-eks-working-dev-wallet"
    #   protocol    = "tcp"
    #   from_port   = 443
    #   to_port     = 443
    #   type        = "ingress"
    #   cidr_blocks = ["10.0.23.142/32"]
    # }


  }

  ## EKS CLuster 
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }

    ingress_metric = {
      description                   = "Node metric ingress"
      protocol                      = "tcp"
      from_port                     = 4443
      to_port                       = 4443
      type                          = "ingress"
      source_cluster_security_group = true
    }

    # ingress_form_prometheus = {
    #   description                   = "Node metric ingress from promtheus"
    #   protocol                      = "tcp"
    #   from_port                     = 6443
    #   to_port                       = 6443
    #   type                          = "ingress"
    #   source_cluster_security_group = true
    # }    


    # ingress_nlb_health_31276_64 = {
    #   description                   = "kubernetes.io/rule/nlb/health=a8bcff418155d4083aa668d26edcaa50"
    #   protocol                      = "tcp"
    #   from_port                     = 31276
    #   to_port                       = 31276
    #   type                          = "ingress"
    #   cidr_blocks                   = ["10.0.32.64/27"]
    # }    

    # ingress_nlb_health_31276_96 = {
    #   description                   = "kubernetes.io/rule/nlb/health=a8bcff418155d4083aa668d26edcaa50"
    #   protocol                      = "tcp"
    #   from_port                     = 31276
    #   to_port                       = 31276
    #   type                          = "ingress"
    #   cidr_blocks                   = ["10.0.32.96/27"]
    # }   

    # ingress_nlb_health_30282_64 = {
    #   description                   = "kubernetes.io/rule/nlb/health=a8bcff418155d4083aa668d26edcaa50"
    #   protocol                      = "tcp"
    #   from_port                     = 30282
    #   to_port                       = 30282
    #   type                          = "ingress"
    #   cidr_blocks                   = ["10.0.32.64/27"]
    # }        

    # ingress_nlb_health_30282_96 = {
    #   description                   = "kubernetes.io/rule/nlb/health=a8bcff418155d4083aa668d26edcaa50"
    #   protocol                      = "tcp"
    #   from_port                     = 30282
    #   to_port                       = 30282
    #   type                          = "ingress"
    #   cidr_blocks                   = ["10.0.32.96/27"]
    # }      

    # ingress_nlb_client_31797 = {
    #   description                   = "kubernetes.io/rule/nlb/client=a8bcff418155d4083aa668d26edcaa50"
    #   protocol                      = "tcp"
    #   from_port                     = 31797
    #   to_port                       = 31797
    #   type                          = "ingress"
    #   cidr_blocks                   = ["0.0.0.0/0"]
    # }  
    #not in stg
    # ingress_nlb_client_30305 = {
    #   description                   = "kubernetes.io/rule/nlb/client=a8bcff418155d4083aa668d26edcaa50"
    #   protocol                      = "icmp"
    #   from_port                     = -1
    #   to_port                       = -1
    #   type                          = "ingress"
    #   cidr_blocks                   = ["0.0.0.0/0"]
    # }      

    # ingress_nlb_client_31967 = {
    #   description                   = "kubernetes.io/rule/nlb/client=ad55ba626586f45d785a34cbc3e1e5ae"
    #   protocol                      = "tcp"
    #   from_port                     = 31967 
    #   to_port                       = 31967 
    #   type                          = "ingress"
    #   cidr_blocks                   = ["0.0.0.0/0"]
    # }        

    # ingress_nlb_client_31068 = {
    #   description                   = "kubernetes.io/rule/nlb/client=ad55ba626586f45d785a34cbc3e1e5ae"
    #   protocol                      = "tcp"
    #   from_port                     = 31068 
    #   to_port                       = 31068
    #   type                          = "ingress"
    #   cidr_blocks                   = ["0.0.0.0/0"]
    # } 


    egress_redis = {
      description = "Node redis egress"
      protocol    = "tcp"
      from_port   = 6379
      to_port     = 6379
      type        = "egress"
      cidr_blocks = data.terraform_remote_state.network.outputs.wallet_db_cidr_blocks
    }

    egress_mysql = {
      description = "Node aurora mysql egress"
      protocol    = "tcp"
      from_port   = 3306
      to_port     = 3306
      type        = "egress"
      cidr_blocks = data.terraform_remote_state.network.outputs.wallet_db_cidr_blocks
    }

    egress_mysql_ue2 = {
      description = "Node aurora mysql ue2 egress"
      protocol    = "tcp"
      from_port   = 3306
      to_port     = 3306
      type        = "egress"
      cidr_blocks = data.terraform_remote_state.network_ue2.outputs.db_cidr_blocks
    }

    egress_kms_8080 = {
      description = "Node kms egress"
      protocol    = "tcp"
      from_port   = 8080
      to_port     = 8080
      type        = "egress"
      cidr_blocks = var.environment == "dev" ? data.terraform_remote_state.network.outputs.wallet_app_cidr_blocks : data.terraform_remote_state.network.outputs.wallet_lb_cidr_blocks
    }

    egress_kms_8443 = {
      description = "Node kms egress"
      protocol    = "tcp"
      from_port   = 8443
      to_port     = 8443
      type        = "egress"
      cidr_blocks = var.environment == "dev" ? data.terraform_remote_state.network.outputs.wallet_app_cidr_blocks : data.terraform_remote_state.network.outputs.wallet_lb_cidr_blocks
    }

    egress_ue2_eks = {
      description = "Node Ohio EKS egress"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      type        = "egress"
      cidr_blocks = data.terraform_remote_state.network_ue2.outputs.lb_cidr_blocks
    }

    egress_ue2_dev_eks = {
      description = "Node Ohio DEV egress"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      type        = "egress"
      cidr_blocks = ["10.0.4.0/26"]
    }

    egress_all = {
      description = "Node all egress"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      self        = true
    }

    egress_tuna_tcp = {
      description = "Node tuna tcp egress"
      protocol    = "tcp"
      from_port   = 6100
      to_port     = 6100
      type        = "egress"
      cidr_blocks = ["${data.terraform_remote_state.comm_ue2.outputs.tuna_private_ip}/32"]
    }

    egress_tuna_udp = {
      description = "Node tuna udp egress"
      protocol    = "udp"
      from_port   = 6100
      to_port     = 6100
      type        = "egress"
      cidr_blocks = ["${data.terraform_remote_state.comm_ue2.outputs.tuna_private_ip}/32"]
    } 

    egress_ntp_udp = {
      description = "Egress NTP/UDP to internet"
      protocol    = "udp"
      from_port   = 123
      to_port     = 123
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"]
    } 

    egress_ntp_tcp = {
      description = "Egress NTP/TCP to internet"
      protocol    = "tcp"
      from_port   = 123
      to_port     = 123
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"]
    }     

    egress_ohio_redis_a = {
      description = "access ohio redis a"
      protocol    = "tcp"
      from_port   = 6379
      to_port     = 6379
      type        = "egress"
      cidr_blocks = [data.terraform_remote_state.network_ue2.outputs.db_cidr_blocks[0]]
    }

    egress_ohio_redis_b = {
      description = "access ohio redis b"
      protocol    = "tcp"
      from_port   = 6379
      to_port     = 6379
      type        = "egress"
      cidr_blocks = [data.terraform_remote_state.network_ue2.outputs.db_cidr_blocks[1]]
    }    

    # egress_tcp_udp = {
    #   description = "Egress TCP/UDP to internet"
    #   protocol    = "tcp"
    #   from_port   = 123
    #   to_port     = 123
    #   type        = "egress"
    #   cidr_blocks = ["0.0.0.0/0"]
    # }         

    # egress_metric = {
    #   description = "Metric"
    #   protocol    = "tcp"
    #   from_port   = 4443
    #   to_port     = 4443
    #   type        = "egress"
    #   cidr_blocks = ["0.0.0.0/0"]
    # }       


  }

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type   = "AL2_x86_64"
    subnet_ids = data.terraform_remote_state.network.outputs.wallet_app_subnets

    disk_size      = 50
    instance_types = var.eks_node_instance_types
    #vpc_security_group_ids = [aws_security_group.additional_http.id, aws_security_group.additional_https.id]
  }

  eks_managed_node_groups = {
    wallet_central_bottlerocket_node = {
      create = true
      cluster_version = "1.24"
      force_update_version = var.environment == "prd" ? false : false

      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = var.central_wallet_bottlerocket_node.min_size
      max_size     = var.central_wallet_bottlerocket_node.max_size
      desired_size = var.central_wallet_bottlerocket_node.desired_size

      instance_types = try(var.central_wallet_bottlerocket_node.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type
      create_iam_role = true
      #iam_role_additional_policies = [aws_iam_policy.ClusterEncryption.arn]
      iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/wallet_central_bottlerocket_node-eks-node-group"      

      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "centralwallet"
      EOT

      tags = {
        System                      = "centralwallet",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "1"
      }
    }

    wallet_central_bottlerocket_node_v2 = {
      create = true
      cluster_version = "1.24"
      force_update_version = var.environment == "prd" ? false : false
      
      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = var.central_wallet_bottlerocket_node_v2.min_size
      max_size     = var.central_wallet_bottlerocket_node_v2.max_size
      desired_size = var.central_wallet_bottlerocket_node_v2.desired_size

      instance_types = try(var.central_wallet_bottlerocket_node_v2.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type

      create_iam_role = true
      iam_role_additional_policies = ["${var.cluster_encryption_policy}"]
      #iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/wallet_central_bottlerocket_node-eks-node-group"

      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "centralwallet"
      EOT

      tags = {
        System                      = "centralwallet",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "1"
      }
    }    

    wallet_manage_bottlerocket_node = {
      create = true
      cluster_version = "1.24"
      force_update_version = var.environment == "prd" ? false : false

      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = var.management_bottlerocket_node.min_size
      max_size     = var.management_bottlerocket_node.max_size
      desired_size = var.management_bottlerocket_node.desired_size

      instance_types = try(var.management_bottlerocket_node.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type
      create_iam_role = true
      iam_role_additional_policies = ["${var.cluster_encryption_policy}"]

      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "management"
      EOT     

      tags = {
        System                      = "centralwallet",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "1"
      }
    }

    wallet_manage_bottlerocket_node_v2 = {
      create = true
      cluster_version = "1.24"
      force_update_version = var.environment == "prd" ? false : false

      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = var.manage_bottlerocket_node_v2.min_size
      max_size     = var.manage_bottlerocket_node_v2.max_size
      desired_size = var.manage_bottlerocket_node_v2.desired_size

      instance_types = try(var.manage_bottlerocket_node_v2.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type
      create_iam_role = true
      iam_role_additional_policies = ["${var.cluster_encryption_policy}"]
      #iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/wallet_management_bottlerocket_node-eks-node-group"      

      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "management"
      EOT     

      tags = {
        System                      = "centralwallet",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "1"
      }
    }    

    wallet_b_office_bottlerocket_node = {
      create = true
      cluster_version = "1.24"
      force_update_version = var.environment == "prd" ? false : false

      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = var.backoffice_bottlerocket_node.min_size
      max_size     = var.backoffice_bottlerocket_node.max_size
      desired_size = var.backoffice_bottlerocket_node.desired_size

      instance_types = try(var.backoffice_bottlerocket_node.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type

      create_iam_role = true
      iam_role_additional_policies = ["${var.cluster_encryption_policy}"]


      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "backoffice"
      EOT     

      tags = {
        System                      = "backoffice",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "2"
      }
    }

    wallet_b_office_bottlerocket_node_v2 = {
      create = true
      cluster_version = "1.24"
      force_update_version = var.environment == "prd" ? false : false

      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = var.b_office_bottlerocket_node_v2.min_size
      max_size     = var.b_office_bottlerocket_node_v2.max_size
      desired_size = var.b_office_bottlerocket_node_v2.desired_size

      instance_types = try(var.b_office_bottlerocket_node_v2.instance_types, var.eks_node_instance_types)
      capacity_type  = var.capacity_type

      create_iam_role = true
      iam_role_additional_policies = ["${var.cluster_encryption_policy}"]
      #iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/wallet_backoffice_bottlerocket_node-eks-node-group"


      iam_role_use_name_prefix   = false
      enable_bootstrap_user_data = true

      bootstrap_extra_args = <<-EOT
      [settings.kernel]
      lockdown = "integrity"

      [settings.kubernetes.node-labels]
      "System" = "backoffice"
      EOT     

      tags = {
        System                      = "backoffice",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "2"
      }
    }    

    wallet_feature_bottlerocket_node = {
      create = var.environment == "dev" ? true : false
      cluster_version = var.environment == "prd" ? "1.23" : (contains(["dev"],var.environment)? "1.24" : "1.23")
      force_update_version = var.environment == "prd" ? false : false

      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      min_size     = try(var.feature_bottlerocket_node.min_size, 0)
      max_size     = try(var.feature_bottlerocket_node.max_size, 0)
      desired_size = try(var.feature_bottlerocket_node.min_size, 0)

      create_iam_role = true
      iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/wallet_feature_bottlerocket_node-eks-node-group"

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
        System                      = "centralwallet",
        BusinessOwnerPrimary        = "infra@bithumbmeta.io",
        SupportPlatformOwnerPrimary = "BithumMeta",
        OperationLevel              = "1"
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
      }, {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/argocd-an2-role"
      username = "${var.environment}-argocd-an2-role"
      groups   = ["system:masters"]
    },{
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/EKSWorking-AssumeRole"
      username = "EKSWorking-AssumeRole"
      groups   = ["system:masters"]
    }
  ]

  tags = {
    Name                                                                                          = "eks-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}"
    "k8s.io/cluster-autoscaler/enabled"                                                           = 1
    "k8s.io/cluster-autoscaler/eks-${var.aws_shot_region}-${var.environment}-${var.wallet_service_name}" = 1
    System                      = "centralwallet",
    BusinessOwnerPrimary        = "infra@bithumbmeta.io",
    SupportPlatformOwnerPrimary = "BithumMeta",
    OperationLevel              = "1"
  }
}


# resource "aws_security_group_rule" "egress_ohio_redis_a" {
#   description       = "access ohio redis a"
#   type              = "egress"  
#   from_port         = 6379
#   to_port           = 6379
#   protocol          = "tcp"
#   cidr_blocks       = ["10.0.5.0/27"]
#   security_group_id = "sg-018a10e5133c58e1b"
# }

# resource "aws_security_group_rule" "egress_ohio_redis_b" {
#   description       = "access ohio redis b"
#   type              = "egress"
#   from_port         = 6379
#   to_port           = 6379
#   protocol          = "tcp"
#   cidr_blocks       = ["10.0.5.32/27"]
#   security_group_id = "sg-018a10e5133c58e1b"
# }

