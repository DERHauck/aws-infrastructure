resource "helm_release" "open_proxy" {
  name      = "${local.client_id}-openproxy"
  namespace = var.namespace
  version   = "6.2.2"

  repository = "https://oauth2-proxy.github.io/manifests"
  chart      = "oauth2-proxy"
  values = [
    templatefile("${path.module}/oauth.yaml", {
      full_domain: "${var.sub_domain}.${var.host_domain}"
      sso_domain: var.sso_domain
      oidc_secret_name: kubernetes_secret.open_proxy.metadata[0].name
      redis_secret_name = var.redis_secret_name
      redis_endpoint = var.redis_endpoint
    })
  ]
  dynamic "set" {
    for_each = length(var.allowed_role) > 0 ? [var.allowed_role] : []
    content {
      name = "extraArgs.allowed-role"
      value = set.value
    }
  }
  depends_on = [
    kubernetes_secret.open_proxy
  ]
}

resource "kubernetes_secret" "open_proxy" {
  metadata {
    name = "${local.client_id}-openproxy-oidc"
    namespace = var.namespace
  }
  data = {
    client-id: var.oidc_id
    client-secret: var.oidc_secret
    cookie-secret: random_password.open_proxy_cookie_secret.result
  }

}
resource "random_password" "open_proxy_cookie_secret" {
  length           = 32
  override_special = "-_"
}