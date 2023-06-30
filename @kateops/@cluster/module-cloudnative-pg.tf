module "cloudnative-pg" {
  source           = "./cloudnative-pg-installation"
  namespace = kubernetes_namespace.security.metadata[0].name
}