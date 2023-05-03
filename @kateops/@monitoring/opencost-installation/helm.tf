resource "helm_release" "opencost" {
  name      = local.name
  namespace = var.namespace
  version = "1.96.0"

  repository = "https://kubecost.github.io/cost-analyzer"
  chart      = "cost-analyzer"
  values = local.templates
}
locals {
  name = "opencost"
}