resource "helm_release" "node_exporter" {
  name      = "ksm"
  namespace = var.namespace

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-state-metrics"

  values = local.templates
}