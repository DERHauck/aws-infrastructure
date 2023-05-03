resource "helm_release" "node_exporter" {
  name      = "node-exporter"
  namespace = var.namespace

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "node-exporter"

  values = local.templates
}