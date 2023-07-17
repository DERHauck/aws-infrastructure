resource "keycloak_group" "this" {
  name     = var.name
  realm_id = local.realm_id
}

data "keycloak_openid_client" "vault" {
  realm_id = local.realm_id
  client_id = "vault"
}

resource "keycloak_role" "this" {
  name     = local.sanitized_name
  realm_id = local.realm_id
  client_id = data.keycloak_openid_client.vault.id
}

resource "keycloak_group_roles" "mapping" {
  realm_id = local.realm_id
  group_id = keycloak_group.this.id
  role_ids = [
    keycloak_role.this.id
  ]
}
