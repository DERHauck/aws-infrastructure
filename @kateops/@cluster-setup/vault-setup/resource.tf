resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "kubernetes" {
  backend = vault_auth_backend.kubernetes.path
  kubernetes_host = var.kubernetes_host
  kubernetes_ca_cert = var.kubernetes_ca_cert
}

resource "vault_kubernetes_auth_backend_role" "kubernetes" {
  backend = vault_auth_backend.kubernetes.path
  role_name = "admin"
  bound_service_account_names = ["*"]
  bound_service_account_namespaces = ["deployment"]
  token_policies = ["admin"]
  token_ttl = 9000
}