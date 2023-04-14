resource "keycloak_openid_client" "portainer" {
  realm_id = data.keycloak_realm.master.id
  client_id = "portainer"
  name = "portainer"
  access_type = "CONFIDENTIAL"
  standard_flow_enabled = true
  valid_redirect_uris = [
    "https://${local.portainer_domain}/*"
  ]
  login_theme = "keycloak"
}

resource "keycloak_openid_client_default_scopes" "portainer_default_scope" {
  realm_id = data.keycloak_realm.master.id
  client_id = keycloak_openid_client.portainer.id
  default_scopes = local.default_scopes
}

resource "vault_generic_secret" "portainer_oidc" {
  path      = "kateops/keycloak/oidc/portainer"
  data_json = jsonencode({
    id: keycloak_openid_client.portainer.client_id
    secret: keycloak_openid_client.portainer.client_secret
  })
}