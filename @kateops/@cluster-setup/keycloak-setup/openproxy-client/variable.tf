variable "realm" {
  type = string
  description = "Keycloak realm name"
}

variable "client_name" {
  type = string
  description = "Keycloak client nane"
}

variable "host_domain" {
  type = string
  default = "kateops.com"
  description = "Client Host Domain"
}

variable "sub_domain" {
  type = string
  description = "Client Subdomain, defaults to lowercase client name"
  default = ""
}