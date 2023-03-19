####################################
# Install nginx ingress controller #
####################################
locals {
  lb_scheme = var.public ? "internet-facing" : "internal"
}
resource "helm_release" "ingress" {
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  name       = "nginx"
  version = "4.3.0"

  namespace        = var.namespace

  values = [
  for yaml in fileset("${path.module}/values", "*.yaml") : templatefile("${path.module}/values/${yaml}", {
    tcp = var.tcp
    lb_scheme = local.lb_scheme
    ip_family = var.ip_family
  })
  ]
}

