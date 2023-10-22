variable "namespace" {
  type = string
  description = "namespace to install argo"
}

variable "argo_host_name" {
  type = string
  description = "argo host name"
}

variable "webhook_host_name" {
  type = string
  description = "argo webhook host name"
}

variable "redis" {
  type = object({
    port = number
    password = string
    host-master = string
    host-read = string
  })
}