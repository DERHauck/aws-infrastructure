variable "namespace" {
  type        = string
  description = "Kubernetes Namespace"
}

variable "oidc_issuer" {
  type = string
  description = "EKS OIDC Issuer"
}

