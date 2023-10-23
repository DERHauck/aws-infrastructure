resource "helm_release" "loki" {
  name      = "loki"
  namespace = var.namespace

  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-distributed"
  version = "0.76.0"
  timeout = "3000"

  values = local.templates
}