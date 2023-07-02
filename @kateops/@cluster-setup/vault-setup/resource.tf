resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "kubernetes" {
  backend = vault_auth_backend.kubernetes.path
  kubernetes_host = var.kubernetes_host
  kubernetes_ca_cert = kubernetes_secret.kubernetes_auth.data["ca.crt"]
  #token_reviewer_jwt = kubernetes_secret.kubernetes_auth.data["token"]
  issuer = "https://kubernetes.default.svc"
}

resource "kubernetes_service_account" "kubernetes_auth" {
  metadata {
    name = "vault-auth-kubernetes-backend"
    namespace = "security"
  }
}

resource "kubernetes_secret" "kubernetes_auth" {
  metadata {
    name = "vault-auth-kubernetes-backend"
    namespace = kubernetes_service_account.kubernetes_auth.metadata[0].namespace
    annotations = {
      "kubernetes.io/service-account.name": kubernetes_service_account.kubernetes_auth.metadata[0].name
    }
  }
  type = "kubernetes.io/service-account-token"
}

resource "kubernetes_cluster_role_binding" "kubernetes_auth" {
  metadata {
    name = "vault-auth-kubernetes-backend-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
  }
  subject {
    kind = "ServiceAccount"
    name = "vault-irsa"
    namespace = kubernetes_service_account.kubernetes_auth.metadata[0].namespace
  }
}

resource "vault_kubernetes_auth_backend_role" "kubernetes" {
  backend = vault_auth_backend.kubernetes.path
  role_name = "admin"
  bound_service_account_names = ["*"]
  bound_service_account_namespaces = ["*"]
  token_policies = ["admin"]
  token_ttl = 9000
}