variable "namespace" {
  type = string
  description = "Kubernetes Namespace"
}

variable "helm_name" {
  type = string
  description = "Helm deployment name"
}

variable "gf_smtp_host" {
  type = string
  description = "SMTP mail host"
}

variable "gf_smtp_password" {
  type = string
  description = "SMTP mail password"
}

variable "gf_smtp_username" {
  type = string
  description = "SMTP mail username"
}

variable "host_domain" {
  type = string
  description = "Public service host domain"
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


variable "rdbs" {
  type = object({
    host = string
    username = string
    password = string
    port = number
    database = string
  })
  description = "TF resource output of rdbs"
}