resource "kubernetes_secret" "this_connections" {
  metadata {
    name = "${local.name}-connections"
    namespace = var.namespace
  }
  data = {
    DATABASE_URL =  "postgres://${var.rdbs.username}:${urlencode(var.rdbs.password)}@${var.rdbs.host}:${var.rdbs.port}/${var.rdbs.database}"
    REDIS_URL = "redis://:${var.redis_password}@${var.redis_endpoint}" #:${data.vault_generic_secret.redis.data["password"]}@${data.vault_generic_secret.redis.data["host-master"]}:${data.vault_generic_secret.redis.data["port"]}"
  }
}

resource "kubernetes_secret" "this_oidc" {
  metadata {
    name = "${local.name}-oidc"
    namespace = var.namespace
  }
  data = {
    OIDC_CLIENT_ID = data.vault_generic_secret.oidc.data["id"]
    OIDC_CLIENT_SECRET = data.vault_generic_secret.oidc.data["secret"]
    OIDC_AUTH_URI = "https://sso.kateops.com/realms/master/protocol/openid-connect/auth"
    OIDC_TOKEN_URI = "https://sso.kateops.com/realms/master/protocol/openid-connect/token"
    OIDC_USERINFO_URI = "https://sso.kateops.com/realms/master/protocol/openid-connect/userinfo"
    OIDC_DISPLAY_NAME = "Kateops SSO"
  }
}