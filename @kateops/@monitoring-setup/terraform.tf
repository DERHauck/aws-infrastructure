terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    grafana = {
      source = "grafana/grafana"
      version = "1.25.0"
    }
  }
}