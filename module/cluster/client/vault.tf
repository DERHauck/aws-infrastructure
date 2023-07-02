resource "vault_mount" "this" {
  path        = local.sanitized_name
  type        = "kv"
  description = "${var.name} K/V vault"
  options     = {
    version = 2
  }
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}

locals {
  vault_manifests_path = "${path.module}/vault-manifests"
}

data "vault_policy_document" "this" {
  rule {
    path         = "/${local.sanitized_name}/*"
    capabilities = ["create", "update", "read", "delete", "list"]
  }
}

resource "vault_policy" "this" {
  name   = local.sanitized_name
  policy = data.vault_policy_document.this.hcl
}

resource "vault_kubernetes_auth_backend_role" "kubernetes" {
  backend                          = "kubernetes"
  role_name                        = local.sanitized_name
  bound_service_account_names      = [kubernetes_service_account.vault.metadata[0].name]
  bound_service_account_namespaces = [kubernetes_namespace.this.metadata[0].name]
  token_policies                   = [vault_policy.this.name]
  token_ttl                        = 9000
}


resource "kubernetes_service_account" "vault" {
  metadata {
    name      = "vault-auth-kubernetes-backend"
    namespace = kubernetes_namespace.this.metadata[0].name
  }
}
#
#resource "kubernetes_role" "vault" {
#  metadata {
#    name      = "vault-auth-kubernetes-backend-role"
#    namespace = kubernetes_namespace.this.metadata[0].name
#  }
#  rule {
#    api_groups = ["authorization.k8s.io"]
#    resources  = ["*"]
#    verbs      = ["create"]
#  }
#  rule {
#    api_groups = ["authorization.k8s.io"]
#    resources  = ["tokenreviews"]
#    verbs      = ["create"]
#  }
#}

#resource "kubernetes_role_binding" "vault" {
#  metadata {
#    name      = "vault-auth-kubernetes-backend-rb"
#    namespace = kubernetes_namespace.this.metadata[0].name
#  }
#  role_ref {
#    api_group = "rbac.authorization.k8s.io"
#    kind      = "Role"
#    name      = kubernetes_role.vault.metadata[0].name
#  }
#  subject {
#    kind      = "ServiceAccount"
#    name      = kubernetes_service_account.vault.metadata[0].name
#    namespace = kubernetes_namespace.this.metadata[0].name
#  }
#}

resource "kubernetes_secret" "vault_token" {
  metadata {
    name        = "vault-auth-kubernetes-backend"
    namespace   = kubernetes_service_account.vault.metadata[0].namespace
    annotations = {
      "kubernetes.io/service-account.name" : kubernetes_service_account.vault.metadata[0].name
    }
  }
  type = "kubernetes.io/service-account-token"
}


resource "kubectl_manifest" "vault_connection" {
  yaml_body = templatefile("${local.vault_manifests_path}/vault-connection.yaml", {
    namespace     = kubernetes_namespace.this.metadata[0].name
    vault_service = "https://vault.kateops.com"
  })
}

resource "kubectl_manifest" "vault_auth" {
  yaml_body = templatefile("${local.vault_manifests_path}/vault-auth.yaml", {
    namespace       = kubernetes_namespace.this.metadata[0].name
    service_account = kubernetes_service_account.vault.metadata[0].name
    auth_role       = vault_kubernetes_auth_backend_role.kubernetes.role_name
  })
}