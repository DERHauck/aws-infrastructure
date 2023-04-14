resource "keycloak_openid_audience_protocol_mapper" "this" {
  realm_id  = var.realm
  client_id = keycloak_openid_client.this.id
  name      = "${keycloak_openid_client.this.client_id}-audience-mapper"

  included_client_audience = keycloak_openid_client.this.client_id
}


resource "keycloak_openid_user_realm_role_protocol_mapper" "admin_mapper" {
  realm_id                = var.realm
  client_id = keycloak_openid_client.this.id
  name = "admin-role-mapper"
  claim_name = "roles"
  multivalued = true
}
