


resource "helm_release" "promtail" {
  name      = "promtail"
  namespace = var.namespace

  repository = "https://grafana.github.io/helm-charts"
  chart      = "promtail"
  version = "6.2.2"

  values = local.templates
}