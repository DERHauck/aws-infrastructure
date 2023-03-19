module "vault" {
  source = "./vault-installation"
  namespace = kubernetes_namespace.security.metadata[0].name
  oidc_issuer = local.oidc_issuer
}