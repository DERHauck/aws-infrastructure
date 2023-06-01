resource "helm_release" "vault" {
  name      = "vault"
  namespace = var.namespace

  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  values     = local.templates
  version    = "0.24.1"
}