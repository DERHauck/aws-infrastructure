resource "helm_release" "prometheus" {
  name      = "keda"
  namespace = var.namespace
  version = "2.10.2"

  repository = "https://kedacore.github.io/charts"
  chart      = "keda"
  values = local.templates
}