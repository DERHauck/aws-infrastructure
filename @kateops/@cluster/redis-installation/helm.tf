resource "helm_release" "redis" {
  chart = "redis"
  name  = var.helm_name
  namespace = var.namespace

  repository = "https://charts.bitnami.com/bitnami"
  values = concat(local.templates, local.secret_templates)
}