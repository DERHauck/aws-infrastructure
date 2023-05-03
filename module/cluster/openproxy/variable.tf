variable "namespace" {
  type = string
  description = "Kubernetes Namespace"
}

variable "sub_domain" {
  type = string
  description = "Public service subdomain"
}

variable "host_domain" {
  type = string
  description = "Public service host domain"
  default = "kateops.com"
}

variable "sso_domain" {
  type = string
  description = "Single sign on domain"
  default = "sso.kateops.com"
}

variable "oidc_secret" {
  type = string
  description = "Grafana single-sign on client secret"
  sensitive = true
}

variable "oidc_id" {
  type = string
  description = "Grafana single-sign on client id"
  sensitive = true
}

variable "allowed_role" {
  type = string
  description = "Allowed roles"
  default = ""
}

variable "redis_secret_name" {
  type = string
  description = "Redis secret name"
  default = ""
}

variable "redis_endpoint" {
  type = string
  description = "Redis endpoint"
}

variable "admin_role" {
  type = bool
  description = "Is realm admin role required"
  default = true
}