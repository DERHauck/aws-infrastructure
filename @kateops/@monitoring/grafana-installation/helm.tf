resource "helm_release" "grafana" {
  chart = "grafana"
  name  = local.name
  namespace = var.namespace
  version = "6.52.9"
  repository = "https://grafana.github.io/helm-charts"
  values = concat(local.templates, local.secret_templates)
}

locals {
  name = "grafana-default"
}