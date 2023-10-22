resource "kubernetes_secret" "redis_secret" {
  metadata {
    name = "argo-redis-password"
    namespace = var.namespace
  }
  data = {
    redis-password: var.redis.password
  }
}

resource "kubernetes_secret" "argo" {
  metadata {
    name = "argocd-secret"
    namespace = var.namespace
    labels = {
      "app.kubernetes.io/name" = "argocd-secret"
      "app.kubernetes.io/part-of" = "argocd"
      "app.kubernetes.io/component" = "server"
      "app.kubernetes.io/managed-by" = "terraform"
      "app.kubernetes.io/instance" = "argo"
    }
  }
  data = {
    "server.secretkey" = random_password.server_secret_key.result
    "oidc.keycloak.clientSecret" = data.vault_generic_secret.oidc.data["secret"]
  }
}


resource "random_password" "server_secret_key" {
  length = 33
}