data "vault_generic_secret" "grafana_admin" {
  path = "kateops/grafana/admin"
}

data "vault_generic_secret" "redis" {
  path = "kateops/redis/security"
}

