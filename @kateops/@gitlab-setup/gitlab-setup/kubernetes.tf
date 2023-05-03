resource "kubernetes_secret" "runner" {
  metadata {
    name = "runner-registry-ro"
    namespace = var.namespace
  }
  type = "kubernetes.io/dockerconfigjson"
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "hub.kateops.com" = {
          auth = base64encode("${data.gitlab_user.automation.username}:${gitlab_personal_access_token.registry.token}")
        }
        "gitlab.kateops.com" = {
          auth = base64encode("${data.gitlab_user.automation.username}:${gitlab_personal_access_token.registry.token}")
        }
      }
    })
  }
}

data "gitlab_user" "automation" {
  user_id = "1"
}