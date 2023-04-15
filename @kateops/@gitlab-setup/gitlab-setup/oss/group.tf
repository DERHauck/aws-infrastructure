resource "gitlab_group" "this" {
  name = "OSS"
  path = "oss"
  visibility_level = "public"
  default_branch_protection = 3
  request_access_enabled = true
}
resource "gitlab_group_access_token" "this" {
  group        = gitlab_group.this.id
  name         = "Service Token"
  access_level = "maintainer"

  scopes = [
    "api",
    "read_registry",
    "write_registry",
  ]
}

resource "vault_generic_secret" "docker_base_service_token" {
  path      = "kateops/instance/oss/service"
  data_json = jsonencode({
    token: gitlab_group_access_token.this.token
  })
}