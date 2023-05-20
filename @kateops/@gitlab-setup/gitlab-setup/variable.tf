variable "vault_root_token" {
  type = string
  description = "Vault Service Token"
}

variable "namespace" {
  type = string
  description = "Gitlab namespace"
}

variable "kubeconfig" {
  type = string
  description = "Kubeconfig"
}