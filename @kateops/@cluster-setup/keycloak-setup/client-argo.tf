resource "keycloak_openid_client" "argo" {
  realm_id = keycloak_realm.master.id
  client_id = "argo"
  name = "Argo CD"
  access_type = "CONFIDENTIAL"
  standard_flow_enabled = true
  valid_redirect_uris = [
    "https://${local.argo_domain}/*"
  ]
  login_theme = "keycloak"
}

resource "keycloak_openid_client_default_scopes" "argo_default_scope" {
  realm_id = keycloak_realm.master.id
  client_id = keycloak_openid_client.argo.id
  default_scopes = local.default_scopes
}

resource "keycloak_openid_user_realm_role_protocol_mapper" "argo_admin_mapper" {
  realm_id                = keycloak_realm.master.id
  client_id = keycloak_openid_client.argo.id
  name = "admin-role-mapper"
  claim_name = "groups"
  multivalued = true
}


resource "vault_generic_secret" "argo_oidc" {
  path      = "kateops/keycloak/oidc/argo"
  data_json = jsonencode({
    id: keycloak_openid_client.argo.client_id
    secret: keycloak_openid_client.argo.client_secret
  })
}