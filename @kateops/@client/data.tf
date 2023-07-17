data "vault_generic_secret" "gitlab_admin" {
  path = "kateops/gitlab/instance/admin"
}

data "vault_generic_secret" "gitlab_runner" {
  path = "kateops/gitlab/runner"
}

data "vault_generic_secret" "keycloak" {
  path = "admin/keycloak/admin"
}