data "vault_generic_secret" "dashboard_oidc" {
  path = "kateops/keycloak/oidc/dashboard"
}

data "vault_generic_secret" "redis" {
  path = "kateops/redis/security"
}
