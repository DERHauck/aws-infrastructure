resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "kubernetes" {
  backend = vault_auth_backend.kubernetes.path
  kubernetes_host = var.kubernetes_host
  kubernetes_ca_cert = var.kubernetes_ca_cert
}