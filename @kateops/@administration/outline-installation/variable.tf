variable "namespace" {
  type = string
  description = "Kubernetes Namespace"
}

variable "host_domain" {
  type = string
  description = "Public service host domain"
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

variable "redis_endpoint" {
  type = string
}

variable "redis_password" {
  type = string
}