variable "cluster_endpoint" {
  type = string
  description = "Cluster Endpoint"
}

variable "cluster_certificate_authority_data" {
  type = string
  description = "Cluster CA certificate"
}

variable "cluster_name" {
  type = string
  description = "Cluster name"
}

variable "namespace" {
  type = string
  description = "Kubernetes namespace"
}
