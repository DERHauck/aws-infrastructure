resource "kubernetes_secret" "redis_secret" {
  metadata {
    name = "${var.helm_name}-password"
    namespace = var.namespace
  }
  data = {
    (local.password_secret_key): random_password.password.result
  }
}