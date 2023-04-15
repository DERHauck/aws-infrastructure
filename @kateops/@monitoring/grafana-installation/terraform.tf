#########################################################
# Terraform
#########################################################

terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
      version = "2.7.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
  required_version = ">=1.2.8"
}