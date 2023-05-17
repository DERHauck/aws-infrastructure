data "vault_generic_secret" "grafana_oidc" {
  path = "kateops/keycloak/oidc/grafana"
}

data "vault_generic_secret" "opencost_oidc" {
  path = "kateops/keycloak/oidc/opencost"
}

data "vault_generic_secret" "prometheus_oidc" {
  path = "kateops/keycloak/oidc/prometheus"
}

data "vault_generic_secret" "mimir_oidc" {
  path = "kateops/keycloak/oidc/mimir"
}
