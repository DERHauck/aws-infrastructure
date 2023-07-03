module "grafana-setup" {
  source = "./grafana-setup"

  tenant_id = "kateops"
  redis_password = data.vault_generic_secret.redis.data["password"]
  redis_url = "redis://${data.vault_generic_secret.redis.data["host-read"]}:${data.vault_generic_secret.redis.data["port"]}"
}
