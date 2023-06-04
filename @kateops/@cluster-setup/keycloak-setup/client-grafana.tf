resource "keycloak_openid_client" "grafana" {
  realm_id = keycloak_realm.master.id
  client_id = "grafana"
  name = "grafana"
  access_type = "CONFIDENTIAL"
  standard_flow_enabled = true
  valid_redirect_uris = [
    "https://${local.grafana_domain}/*"
  ]
  login_theme = "keycloak"
}

resource "keycloak_openid_client_default_scopes" "grafana_default_scope" {
  realm_id = keycloak_realm.master.id
  client_id = keycloak_openid_client.grafana.id
  default_scopes = local.default_scopes
}

resource "keycloak_openid_user_realm_role_protocol_mapper" "admin_mapper" {
  realm_id                = keycloak_realm.master.id
  client_id = keycloak_openid_client.grafana.id
  name = "admin-role-mapper"
  claim_name = "roles"
  multivalued = true
}


resource "vault_generic_secret" "grafana_oidc" {
  path      = "kateops/keycloak/oidc/grafana"
  data_json = jsonencode({
    id: keycloak_openid_client.grafana.client_id
    secret: keycloak_openid_client.grafana.client_secret
  })
}