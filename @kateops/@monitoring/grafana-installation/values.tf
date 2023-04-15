locals {
  vars = {
    host_domain: var.host_domain
    admin_user: random_string.user.id
    grafana_secret_name: kubernetes_secret.grafana_secret.metadata[0].name
    grafana_smtp_secret_name: kubernetes_secret.grafana_smtp_secret.metadata[0].name
    smtp_username_key: local.smtp_username_key
    smtp_password_key: local.smtp_password_key
  }
  templates = [ for v in fileset("${path.module}/values","*"): templatefile("${path.module}/values/${v}", local.vars) ]
  secret_templates = [] # [ for v in fileset("${path.module}/values","*.yml"): templatefile("${path.module}/values/${v}", local.secrets) ]
}