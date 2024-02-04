terraform {
  required_version = ">= 1.1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.9.0"
    }
    kubernetes = {
      version = "2.10.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Terraform = "True"
    }
  }
}

provider "aws" {
  alias   = "virginia"
  region  = "us-east-1"
}

provider "aws" {
  alias   = "Ohio"
  region  = "us-east-2"
}

data "aws_eks_cluster" "cluster" {
  name = module.gitlab_runner_cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.gitlab_runner_cluster.cluster_id
}

provider "kubernetes" {
  alias                  = "gitlab_runner_eks_provider"
  host                   = module.gitlab_runner_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.gitlab_runner_cluster.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.gitlab_runner_cluster.cluster_id]
  }
}

provider "kubernetes" {
  host                   = module.gitlab_runner_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.gitlab_runner_cluster.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.gitlab_runner_cluster.cluster_id]
  }
}