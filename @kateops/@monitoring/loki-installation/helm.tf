resource "helm_release" "loki" {
  name      = "loki"
  namespace = var.namespace

  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-distributed"
  version = "0.56.6"

  values = local.templates
}