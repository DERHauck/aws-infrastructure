resource "helm_release" "runner" {
  chart = "gitlab-runner"
  name  = "runner-${var.pressure}"
  namespace = var.namespace

  repository = "https://charts.gitlab.io/"
  values = local.templates
  timeout = 180
  version = "0.50.1"
  depends_on = [
  ]
}
#
#module.gitlab.kubernetes_secret.gitlab_postgresql_secret
#module.gitlab.kubernetes_secret.gitlab_s3_registry_credentials
#module.gitlab.kubernetes_secret.gitlab_s3_storage_credentials
#module.gitlab.kubernetes_secret.gitlab_shell_secret
#module.gitlab.kubernetes_secret.oidc_secret