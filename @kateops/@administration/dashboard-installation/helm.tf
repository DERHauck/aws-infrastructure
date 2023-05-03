resource "helm_release" "dashboard" {
  name      = local.name
  namespace = var.namespace
 # version = "2.6.7"

  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  values = local.templates
}
locals {
  name = "kube-dashboard"
}