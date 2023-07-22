variable "namespace" {
  type = string
  description = "Kubernetes Namespace"
}

variable "gitlab_host_domain" {
  type = string
  default = "kateops.com"
}

variable "gitlab_domain_name" {
  type = string
  default = "gitlab.kateops.com"
}

variable "gitlab_registry_domain_name" {
  type = string
  default = "hub.kateops.com"
}

variable "pages_host" {
  type = string
  default = "page.kateops.com"
}

variable "secret_key_name" {
  type = string
  default = "password"
}

variable "storage_class" {
  type = string
  default = "gp2"
}

variable "backup_secret_key_name" {
  type = string
  default = "s3cfg"
}

variable "redis_host" {
  type = string
  description = "Redis Host"
}

variable "redis_password" {
  type = string
  description = "Redis password"
}

variable "access_key_id" {
  type = string
  description = "Scaleway API key id"
  sensitive = true
}

variable "secret_access_key" {
  type = string
  description = "Scaleway API key"
  sensitive = true
}

variable "region" {
  type = string
  description = "Scaleway region default eu-central-1"
}

variable "cluster_issuer_arn" {
  type = string
  description = "Cluster issuer arn"
}

variable "cluster_issuer" {
  type = string
  description = "Cluster issuer"
}