resource "helm_release" "agent-operator" {
  name      = "agent-operator"
  namespace = var.namespace

  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana-agent-operator"

  values = local.templates
  skip_crds = false
}