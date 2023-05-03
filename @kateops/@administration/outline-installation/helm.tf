resource "helm_release" "this" {
  chart = "outline"
  name  = local.name
  namespace = var.namespace

  repository = "https://gitlab.com/api/v4/projects/30221184/packages/helm/stable/"
  values = concat(local.templates, local.secret_templates)
}

locals {
  name = "outline"
}