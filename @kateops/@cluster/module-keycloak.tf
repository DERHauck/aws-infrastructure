module "keycloak" {
  source = "./keycloak-installation"
  namespace = kubernetes_namespace.security.metadata[0].name
}
