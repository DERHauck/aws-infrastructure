resource "kubernetes_secret" "redis_password" {
  metadata {
    name = "redis-password"
    namespace = kubernetes_namespace.this.metadata[0].name
  }
  data = {
    redis-password: data.vault_generic_secret.redis.data["password"]
  }
}