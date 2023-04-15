resource "gitlab_group" "docker_base" {
  name = "Docker Base Images"
  path = "base"
  visibility_level = "public"
  default_branch_protection = 3
  request_access_enabled = true
}
resource "gitlab_group_access_token" "docker_base" {
  group        = gitlab_group.docker_base.id
  name         = "Service Token"
  access_level = "maintainer"

  scopes = [
    "api",
    "read_registry",
    "write_registry",
  ]
}

resource "vault_generic_secret" "docker_base_service_token" {
  path      = "kateops/instance/base/service"
  data_json = jsonencode({
    token: gitlab_group_access_token.docker_base.token
  })
}