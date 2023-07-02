resource "helm_release" "mimir" {
  name      = "vault-operator"
  namespace = var.namespace

  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault-secrets-operator"

  values = local.templates
}