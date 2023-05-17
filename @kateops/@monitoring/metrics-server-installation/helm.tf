resource "helm_release" "metrics_server" {
  name      = "metrics"
  namespace = var.namespace

  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"

  values = local.templates
}