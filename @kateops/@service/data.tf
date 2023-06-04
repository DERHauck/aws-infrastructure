
data "vault_generic_secret" "nextcloud_oidc" {
  path = "kateops/keycloak/oidc/nextcloud"
}

data "vault_generic_secret" "redis" {
  path = "kateops/redis/security"
}
