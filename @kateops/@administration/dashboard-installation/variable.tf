variable "namespace" {
  type = string
  description = "Kubernetes Namespace"
}


variable "host_domain" {
  type = string
  description = "Public service host domain"
}

variable "service_account_name" {
  type = string
  description = "Service Account Name to use"
  default = "octant-readonly-sa"
}

variable "is_admin" {
  type = bool
  description = "Is service Account supposed to be admin"
  default = false
}