resource "helm_release" "mimir" {
  name      = "mimir"
  namespace = var.namespace

  repository = "https://grafana.github.io/helm-charts"
  chart      = "mimir-distributed"

  values = local.templates
}