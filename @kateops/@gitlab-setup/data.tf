data "vault_generic_secret" "gitlab_admin" {
  path = "kateops/gitlab/instance/admin"
}