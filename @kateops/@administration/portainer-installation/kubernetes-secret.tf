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