variable "namespace" {
  type = string
  description = "Kubernetes Namespace"
}

variable "mimir_service" {
  type = string
  description = "Mimir Distributer Service with Port"
}