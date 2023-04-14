resource "vault_generic_secret" "this" {
  path      = "kateops/keycloak/oidc/${local.client_id}"
  data_json = jsonencode({
    id: keycloak_openid_client.this.client_id
    secret: keycloak_openid_client.this.client_secret
  })
}
