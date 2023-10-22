resource "kubectl_manifest" "database" {
  yaml_body = templatefile("${path.module}/database.yaml", {
    namespace = var.namespace
  })
}

data "kubernetes_secret" "keycloak-cluster-app" {
  metadata {
    name = "keycloak-cluster-app"
    namespace = var.namespace
  }
}