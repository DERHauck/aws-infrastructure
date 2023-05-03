terraform {
  required_providers {
    aws = {
      version = "4.53.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "15.11.0"
    }
  }
}