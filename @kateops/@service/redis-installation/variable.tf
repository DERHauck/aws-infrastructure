variable "namespace" {
  type = string
  description = "Kubernetes Namespace"
}

variable "helm_name" {
  type = string
  description = "Helm deployment name"
}

variable "monitoring_namespace" {
  type = string
  description = "Name of the monitoring namespace where prometheus is"
}