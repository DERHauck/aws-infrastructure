terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "16.5.0"
    }
  }
}