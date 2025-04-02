terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}

data "aws_eks_cluster_auth" "eks_auth" {
  name = var.cluster_name
}

provider "helm" {
  kubernetes {
    host = var.cluster_endpoint
    token = data.aws_eks_cluster_auth.eks_auth.token
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}

resource "helm_release" "chart" {
  name       = var.release_name
  namespace  = var.namespace
  repository = var.repo_url
  chart      = var.chart_name
  version    = var.chart_version
  create_namespace = true
  values = var.values
}
