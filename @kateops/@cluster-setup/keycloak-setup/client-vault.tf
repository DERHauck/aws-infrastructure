resource "keycloak_openid_client" "openid_client" {
  realm_id  = data.keycloak_realm.master.id
  client_id = "vault"

  name                  = "vault"
  enabled               = true
  standard_flow_enabled = true

  access_type         = "CONFIDENTIAL"
  valid_redirect_uris = [
    "https://vault.kateops.com/*"
  ]

  login_theme = "keycloak"
}

resource "keycloak_role" "admin" {
  realm_id    = data.keycloak_realm.master.id
  client_id   = keycloak_openid_client.openid_client.id
  name        = "admin"
  description = "Administration access role"
}

resource "keycloak_role" "management_role" {
  realm_id    = data.keycloak_realm.master.id
  client_id   = keycloak_openid_client.openid_client.id
  name        = "management"
  description = "Management role"
}

resource "keycloak_role" "reader_role" {
  realm_id    = data.keycloak_realm.master.id
  client_id   = keycloak_openid_client.openid_client.id
  name        = "reader"
  description = "Reader role"
}

resource "keycloak_openid_user_client_role_protocol_mapper" "user_client_role_mapper" {
  realm_id   = data.keycloak_realm.master.id
  client_id  = keycloak_openid_client.openid_client.id
  name       = "user-client-role-mapper"
  claim_name = format(
    "resource_access.%s.roles",
    "vault"
  )
  client_id_for_role_mappings = keycloak_openid_client.openid_client.name

  multivalued = true
}