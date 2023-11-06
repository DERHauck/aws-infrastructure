terraform {
  required_providers {
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