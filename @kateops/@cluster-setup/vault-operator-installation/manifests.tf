resource "kubectl_manifest" "vault_connection" {
  yaml_body = templatefile("${path.module}/manifests/vault-connection.yaml", {
    vault_service = var.vault_service
    namespace = var.namespace
  })
}

resource "kubectl_manifest" "vault_auth" {
  yaml_body = templatefile("${path.module}/manifests/vault-auth.yaml", {
    namespace = var.namespace
  })
}

resource "kubectl_manifest" "test" {
  yaml_body = templatefile("${path.module}/manifests/test.yaml", {
    namespace = var.namespace
  })
}

resource "kubectl_manifest" "test2" {
  yaml_body = templatefile("${path.module}/manifests/test2.yaml", {
    namespace = var.namespace
  })
}