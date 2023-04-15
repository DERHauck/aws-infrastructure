resource "kubernetes_secret" "grafana_secret" {
  metadata {
    name = "${var.helm_name}-env"
    namespace = var.namespace
  }
  data = {
    admin-password: random_password.admin.result
    admin-user: random_string.user.result
    GF_AUTH_GENERIC_OAUTH_CLIENT_SECRET: var.oidc_secret
    GF_AUTH_GENERIC_OAUTH_CLIENT_ID: var.oidc_id
    GF_DATABASE_TYPE: "postgres"
    GF_DATABASE_HOST: "${var.rdbs.host}:${var.rdbs.port}"
    GF_DATABASE_NAME: var.rdbs.database
    GF_DATABASE_USER: var.rdbs.username
    GF_DATABASE_PASSWORD: var.rdbs.password
    GF_DATABASE_SSL_MODE: "disable"
    GF_SMTP_HOST: var.gf_smtp_host
    GF_SMTP_FROM_ADDRESS: var.gf_smtp_username
    GF_SMTP_STARTTLS_POLICY: "NoStartTLS"
  }
}

resource "kubernetes_secret" "grafana_smtp_secret" {
  metadata {
    name = "${var.helm_name}-smtp"
    namespace = var.namespace
  }
  data = {
    (local.smtp_password_key): var.gf_smtp_password
    (local.smtp_username_key): var.gf_smtp_username
  }
}