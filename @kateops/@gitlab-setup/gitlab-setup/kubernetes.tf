resource "kubernetes_secret" "runner" {
  for_each = toset(["gitlab", "deployment"])
  metadata {
    name = "runner-registry-ro"
    namespace = each.key
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