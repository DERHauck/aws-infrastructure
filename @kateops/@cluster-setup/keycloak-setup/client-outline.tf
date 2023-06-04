resource "keycloak_openid_client" "outline" {
  realm_id = keycloak_realm.master.id
  client_id = "outline"
  name = "Outline"
  access_type = "CONFIDENTIAL"
  standard_flow_enabled = true
  valid_redirect_uris = [
    "https://${local.outline_domain}/*"
  ]
  login_theme = "keycloak"
}

resource "keycloak_openid_client_default_scopes" "outline_default_scope" {
  realm_id = keycloak_realm.master.id
  client_id = keycloak_openid_client.outline.id
  default_scopes = local.default_scopes
}

resource "vault_generic_secret" "outline_oidc" {
  path      = "kateops/keycloak/oidc/outline"
  data_json = jsonencode({
    id: keycloak_openid_client.outline.client_id
    secret: keycloak_openid_client.outline.client_secret
  })
}