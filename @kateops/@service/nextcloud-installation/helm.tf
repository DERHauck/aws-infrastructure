resource "helm_release" "this" {
  chart = local.name
  name  = var.helm_name
  namespace = var.namespace
  version = "3.3.3"

  repository = "https://nextcloud.github.io/helm"
  values = concat(local.templates, local.secret_templates)
  depends_on = [
    aws_efs_access_point.this,
    kubernetes_persistent_volume_claim.this
  ]
}

locals {
  name = "nextcloud"
}