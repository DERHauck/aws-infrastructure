resource "vault_kv_secret_v2" "redis" {
  mount = "kateops"
  name = "redis"
  data_json = jsonencode({
    password: random_password.password.result
    port: 6379
    host-master: "redis-master.${var.namespace}.svc.cluster.local"
    host-read: "redis-headless.${var.namespace}.svc.cluster.local"
  })
}

output "connection" {
  value = {
    password = random_password.password.result
    port = 6379
    host-master = "redis-master.${var.namespace}.svc.cluster.local"
    host-read = "redis-headless.${var.namespace}.svc.cluster.local"
  }
}