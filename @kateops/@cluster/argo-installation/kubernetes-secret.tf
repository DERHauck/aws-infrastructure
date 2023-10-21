resource "kubernetes_secret" "redis_secret" {
  metadata {
    name = "argo-redis-password"
    namespace = var.namespace
  }
  data = {
    redis-password: var.redis.password
  }
}