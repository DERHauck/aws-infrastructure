resource "helm_release" "argo" {
  name      = "argo"
  namespace = var.namespace

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  values     = local.templates
  version    = "5.46.8"
  depends_on = [
    kubernetes_config_map.cm,
    kubernetes_secret.argo
  ]
}
