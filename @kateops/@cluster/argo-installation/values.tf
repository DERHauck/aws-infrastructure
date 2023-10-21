locals {
  vars = {
    host_name = var.argo_host_name
    webhook_host_name = var.webhook_host_name
    redis_host = var.redis.host-master
    redis_port = var.redis.port
    redis_password = var.redis.password
    redis_secret_name = kubernetes_secret.redis_secret.metadata[0].name
  }
  templates = [for v in fileset("${path.module}/values", "*.yaml") : templatefile("${path.module}/values/${v}", local.vars)]
}