variable "namespace" {
  type = string
  description = "Kubernetes Namespace"
}

variable "host_domain" {
  type = string
  description = "Public service host domain"
}

variable "fqdn_prometheus_service" {
  type = string
  description = "FQDN for prometheus service including protocol and port"
}

variable "grafana_service" {
  type = string
  description = "Cluster internal service for grafana (port 80 default)"
}

variable "storage_class" {
  type = string
  description = "Persistence storage class (CSI)"
  default = "efs-sc"
}