resource "vault_kv_secret_v2" "redis" {
  mount = "kateops"
  name = "redis"
  data_json = jsonencode({
    password: random_password.password.result
  })
}