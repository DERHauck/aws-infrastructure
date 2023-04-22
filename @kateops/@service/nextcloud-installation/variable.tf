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

variable "host_domain" {
  type = string
  description = "Public service host domain"
}


variable "smtp_password" {
  type = string
  description = "SMTP mail server login address"
}

variable "smtp_host" {
  type = string
  description = "SMTP mail server endpoint"
}

variable "smtp_username" {
  type = string
  description = "SMTP mail server login username"
}

variable "redis_host" {
  type = string
  description = "Redis master host"
}

variable "redis_password" {
  type = string
  description = "Redis password"
}

variable "redis_port" {
  type = string
  description = "Redis port"
}

variable "region" {
  type = string
  description = "Scaleway region"
  default = "eu-central-1"
}

variable "sso_domain" {
  type = string
  description = "Single sign on domain"
  default = "sso.kateops.com"
}

variable "oidc_secret" {
  type = string
  description = "Nextcloud OIDC secret"
}

variable "oidc_id" {
  type = string
  description = "Nextcloud OIDC id"
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

variable "efs_id" {
  type = string
  description = "EFS file system id"
}