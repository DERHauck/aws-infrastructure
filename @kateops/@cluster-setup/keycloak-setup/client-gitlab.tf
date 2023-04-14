resource "keycloak_openid_client" "gitlab" {
  realm_id = data.keycloak_realm.master.id
  client_id = "gitlab"
  name = "Gitlab"
  access_type = "CONFIDENTIAL"
  standard_flow_enabled = true
  valid_redirect_uris = [
    "https://${local.gitlab_domain}/users/auth/openid_connect/callback"
  ]
  login_theme = "keycloak"
}

resource "keycloak_openid_client_default_scopes" "gitlab_default_scope" {
  realm_id = data.keycloak_realm.master.id
  client_id = keycloak_openid_client.gitlab.id
  default_scopes = local.default_scopes
}

resource "vault_generic_secret" "gitlab_oidc" {
  path      = "kateops/keycloak/oidc/gitlab"
  data_json = jsonencode({
    id: keycloak_openid_client.gitlab.client_id
    secret: keycloak_openid_client.gitlab.client_secret
  })
}