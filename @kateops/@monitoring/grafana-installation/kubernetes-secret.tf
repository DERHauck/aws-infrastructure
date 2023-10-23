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
    GF_DATABASE_HOST: "${local.db_host}:${local.db_port}"
    GF_DATABASE_NAME: local.db_name
    GF_DATABASE_USER: local.db_user
    GF_DATABASE_PASSWORD: local.db_password
    GF_DATABASE_SSL_MODE: "disable"
    GF_SMTP_HOST: "${module.ses.host}:${module.ses.port}"
    GF_SMTP_FROM_ADDRESS: "grafana@kateops.com"
    GF_SMTP_STARTTLS_POLICY: "NoStartTLS"
  }
}

resource "kubernetes_secret" "grafana_smtp_secret" {
  metadata {
    name = "${var.helm_name}-smtp"
    namespace = var.namespace
  }
  data = {
    (local.smtp_password_key): module.ses.password
    (local.smtp_username_key): module.ses.username
  }
}