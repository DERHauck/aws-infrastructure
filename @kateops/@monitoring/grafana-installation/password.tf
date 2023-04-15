resource "vault_kv_secret_v2" "grafana" {
  mount = "kateops"
  name = "grafana/admin"
  data_json = jsonencode({
    password: random_password.admin.result
    username: random_string.user.id
  })
}