variable "vault_root_token" {
  type        = string
  description = "Vault Provider Token"
}

variable "kubernetes_host" {
  type = string
  description = "Kubernetes host for auth backend"
}

variable "kubernetes_ca_cert" {
  type = string
  description = "Kubernetes CA Certificate for auth backend"
}
