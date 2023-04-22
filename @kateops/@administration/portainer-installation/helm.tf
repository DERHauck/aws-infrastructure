resource "helm_release" "this" {
  chart = "portainer"
  name  = local.name
  namespace = var.namespace

  repository = "https://portainer.github.io/k8s/"
  values = concat(local.templates, local.secret_templates)
}

locals {
  name = "portainer"
}