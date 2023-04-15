resource "helm_release" "promtail" {
  name      = "node-exporter"
  namespace = var.namespace

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "node-exporter"

  values = local.templates
}