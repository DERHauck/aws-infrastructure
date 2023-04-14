data "vault_generic_secret" "gitlab_oidc" {
  path = "kateops/keycloak/oidc/gitlab"
}

data "kubernetes_secret" "runner_token" {
  metadata {
    name = "gitlab-gitlab-runner-secret"
    namespace = var.namespace
  }
}