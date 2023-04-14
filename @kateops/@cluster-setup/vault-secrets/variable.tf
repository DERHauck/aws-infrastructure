variable "rdbs" {
  type = map(any)
  description = "Map with Scaleway RDBS instances { name => attributes }"
}

variable "keycloak_rdbs" {
  type = map(any)
  description = "Keycloak database credentials"
}


variable "keycloak_realm" {
  type        = string
  description = "Keycloak Realm to integrate into Vault"
}


variable "keycloak_client_id" {
  type        = string
  description = "Keycloak client id for integration into Vault"
}

variable "keycloak_client_secret" {
  type        = string
  description = "Keycloak client secret to for integration into Vault"
  sensitive   = true
}

variable "keycloak_admin_username" {
  type        = string
  description = "Keycloak admin username for provider"
}

variable "keycloak_admin_password" {
  type        = string
  description = "Keycloak admin password for provider"
  sensitive   = true
}

variable "k8_endpoint" {
  type        = string
  description = "Kubernetes endpoint"
}

variable "k8_token" {
  type        = string
  description = "Kubernetes cluster token"
}

variable "k8_certificate" {
  type        = string
  description = "Kubernetes cluster certificate"
}

variable "k8_zone" {
  type        = string
  description = "Kubernetes cluster zone"
}

variable "k8_region" {
  type        = string
  description = "Kubernetes cluster region"
}

variable "access_key" {
  type        = string
  description = "Scaleway Api Access Key"
}

variable "secret_key" {
  type        = string
  description = "Scaleway Api Secret Key"
}

variable "admin_mount_path" {
  type = string
  description = "Vault Admin mount path"
}