variable "namespace" {
  type = string
  description = "EKS Namespace"
}

variable "tcp" {
  type = map(string)
  description = "Does the ingress need to provide custom tcp access"
  default = {}
}

variable "public" {
  type = bool
  description = "If the loadbalancer is supposed to be public or internal only"
  default = false
}

variable "ip_family" {
  type = string
  validation {
    condition = var.ip_family == "IPv6" || var.ip_family == "IPv4"
    error_message = "Wrong ip family! Only 'IPv6' or 'IPv4' available"
  }
  default = "IPv4"
}
