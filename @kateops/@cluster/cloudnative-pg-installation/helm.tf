resource "helm_release" "this" {
  name      = "pg"
  namespace = var.namespace

  repository = "https://cloudnative-pg.github.io/charts"
  chart      = "cloudnative-pg"
  values     = local.templates
  version    = "0.18.1"
}