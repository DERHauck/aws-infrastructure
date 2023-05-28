resource "helm_release" "gitlab" {
  chart = "gitlab"
  name  = "gitlab"
  namespace = var.namespace

  version = "7.0.1"
  repository = "https://charts.gitlab.io/"
  values = local.templates
  timeout = 600
  depends_on = [
    kubernetes_secret.gitlab_postgresql_secret,
    kubernetes_secret.gitlab_s3_storage_credentials,
    kubernetes_secret.gitlab_shell_secret,
  ]
}