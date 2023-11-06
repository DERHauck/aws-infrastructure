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
      version = "16.5.0"
    }
    keycloak = {
      source  = "mrparkers/keycloak"
      version = ">= 3.0.0"
    }
  }
}