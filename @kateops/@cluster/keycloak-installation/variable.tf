variable "namespace" {
  type        = string
  description = "Kubernetes Namespace"
}

variable "keycloak_admin_username" {
  type        = string
  description = "Keycloak admin username"
  default     = "keycloak_admin"
}

#variable "rdbs" {
#  type = object({
#    host = string
#    username = string
#    password = string
#    port = number
#    database = string
#  })
#  description = "TF resource output of rdbs"
#}