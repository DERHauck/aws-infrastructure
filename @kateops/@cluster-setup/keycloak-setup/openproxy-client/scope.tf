resource "keycloak_openid_client_default_scopes" "this" {
  realm_id       = var.realm
  client_id      = keycloak_openid_client.this.id
  default_scopes = [
    "profile",
    "email",
    "acr",
    "web-origins",
    "roles"
  ]
}
