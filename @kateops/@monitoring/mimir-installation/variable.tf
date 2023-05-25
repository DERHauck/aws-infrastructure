variable "namespace" {
  type = string
  description = "Kubernetes Namespace"
}

variable "storage_class" {
  type = string
  description = "Persistence storage class (CSI)"
  default = "gp2"
}

variable "host_domain" {
  type = string
  description = "Public service host domain"
}

variable "region" {
  type = string
  description = "aws region"
  default = "eu-central-1"
}

variable "access_key_name" {
  type = string
  description = "Access key name for kubernetes secret"
  default = "ACCESS_KEY"
}

variable "secret_key_name" {
  type = string
  description = "Secret key name for kubernetes secret"
  default = "SECRET_KEY"
}

variable "tenant_ids" {
  type = list(string)
  description = "List of tenant ids"
  default = []
}