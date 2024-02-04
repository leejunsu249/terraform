module "gitlab_runner_cluster" {
  source = "terraform-aws-modules/eks/aws"
  version = "18.20.1"

  create_iam_role = false
  iam_role_arn    = aws_iam_role.gitlab_runner_cluster_role.arn

  cluster_name                    = "eks-${var.aws_shot_region}-${var.environment}-gitlab"
  cluster_version                 = "1.22"

  cluster_endpoint_public_access = false
  cluster_endpoint_private_access = true

  cluster_enabled_log_types = [ "audit", "authenticator", "api", "controllerManager", "scheduler" ]

  cluster_encryption_config = [{
    provider_key_arn = aws_kms_key.ec2.arn
    resources        = ["secrets"]
  }]

  vpc_id     = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.network.outputs.cluster_subnets

  cluster_security_group_additional_rules = {
    ingress_gitlab = {
      description = "To 443 from gitlab"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      type        = "ingress"
      source_security_group_id  = aws_security_group.gitlab_sg.id
    }

    ingress_vpn = {
      description = "To 443 from vpn"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      type        = "ingress"
      cidr_blocks = ["192.168.1.0/24"]
    }
  }

  # Fargate Profile(s)
  fargate_profiles = {
    gitlab_runner = {
      name = "gitlab-runner"

      subnet_ids = data.terraform_remote_state.network.outputs.node_subnets
      selectors = [
        {
          namespace = "gitlab-runner"
        }
      ]

      tags = {
        Name = "fargate-${var.environment}-${var.service_name}-gitlab"
      }

      timeouts = {
        create = "20m"
        delete = "20m"
      }
    }

    coredns = {
      name = "coredns"
      subnet_ids = data.terraform_remote_state.network.outputs.node_subnets

      selectors = [
        {
          namespace = "kube-system"
          labels = {
            "k8s-app"="kube-dns"
          }
        }
      ]

      tags = {
        Name = "fargate-${var.environment}-${var.service_name}-coredns"
      }
    }
  }

  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "${aws_iam_role.gitlab_repository_role.arn}"
      username = "gitlab-repository"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:eks:us-east-2:676826599814:fargateprofile/eks-ue2-shd-gitlab/gitlab-runner/aec00be2-96d2-6311-f043-44167bf38977"
      username = "system:node:{{SessionName}}"
      groups   = ["system:bootstrappers", "system:nodes", "system:node-proxier"]
    },
    {
      rolearn  = "arn:aws:eks:us-east-2:676826599814:fargateprofile/eks-ue2-shd-gitlab/coredns/12c00be4-2324-e016-f36e-1345cb2e305d"
      username = "system:node:{{SessionName}}"
      groups   = ["system:bootstrappers", "system:nodes", "system:node-proxier"]
    },
    {
      rolearn  = "arn:aws:iam::676826599814:role/shd-gitlab-role"
      username = "gitlab-instance"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::676826599814:role/shd-bastion-role"
      username = "bastion-instance"
      groups   =["system:masters"]
    }  
  ]

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::676826599814:user/Ian"
      username = "ian"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::676826599814:user/kmz765@lgcns.com"
      username = "kmz765@lgcns.com"
      groups   = ["system:masters"]
    }
  ]

  tags = {
    Name = "eks-${var.environment}-gitlab"
  }
}

resource "kubernetes_namespace" "gitlab_runner" {
  provider = kubernetes.gitlab_runner_eks_provider

  metadata {
    annotations = {
      name = "gitlab-runner"
    }

    name = "gitlab-runner"
  }
}

resource "kubernetes_role" "gitlab_admin" {
  provider = kubernetes.gitlab_runner_eks_provider
  metadata {
    name = "gitlab-admin"
    namespace = "gitlab-runner"
  }

  rule {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

resource "kubernetes_role_binding" "gitlab_admin" {
  provider = kubernetes.gitlab_runner_eks_provider

  metadata {
    name = "gitlab-admin"
    namespace = "gitlab-runner"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "gitlab-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "gitlab-admin"
    namespace = "gitlab-runner"
  }
}

resource "kubernetes_service_account" "gitlab_admin" {
  provider = kubernetes.gitlab_runner_eks_provider
  automount_service_account_token = true
  metadata {
    name      = "gitlab-admin"
    namespace = "gitlab-runner"
    annotations = {
      "eks.amazonaws.com/role-arn" = "${aws_iam_role.fargate_role.arn}"
    }
  }
}
