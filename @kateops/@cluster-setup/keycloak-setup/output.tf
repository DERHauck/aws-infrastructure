output "vault_client_id" {
  value = keycloak_openid_client.openid_client.name
}

output "vault_client_secret" {
  value = keycloak_openid_client.openid_client.client_secret
}

output "realm" {
  value = keycloak_realm.master.id
}