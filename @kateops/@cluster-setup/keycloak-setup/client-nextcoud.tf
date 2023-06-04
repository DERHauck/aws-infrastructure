resource "keycloak_openid_client" "nextcloud" {
  realm_id = keycloak_realm.master.id
  client_id = "nextcloud"
  name = "nextcloud"
  access_type = "CONFIDENTIAL"
  standard_flow_enabled = true
  valid_redirect_uris = [
    "https://${local.nextcloud_domain}/*"
  ]
  login_theme = "keycloak"
}

resource "keycloak_openid_client_default_scopes" "nextcloud_default_scope" {
  realm_id = keycloak_realm.master.id
  client_id = keycloak_openid_client.nextcloud.id
  default_scopes = local.default_scopes
}

resource "keycloak_openid_user_realm_role_protocol_mapper" "nextcloud_admin_mapper" {
  realm_id                = keycloak_realm.master.id
  client_id = keycloak_openid_client.nextcloud.id
  name = "admin-role-mapper"
  claim_name = "roles"
  multivalued = true
}


resource "vault_generic_secret" "nextcloud_oidc" {
  path      = "kateops/keycloak/oidc/nextcloud"
  data_json = jsonencode({
    id: keycloak_openid_client.nextcloud.client_id
    secret: keycloak_openid_client.nextcloud.client_secret
  })
}
