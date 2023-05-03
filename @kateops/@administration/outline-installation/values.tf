locals {
  vars = {
    host_domain: var.host_domain
    connection_secret_name: kubernetes_secret.this_connections.metadata[0].name
    oidc_secret_name: kubernetes_secret.this_oidc.metadata[0].name
  }
  templates = [ for v in fileset("${path.module}/values","*"): templatefile("${path.module}/values/${v}", local.vars) ]
  secret_templates = [] # [ for v in fileset("${path.module}/values","*.yml"): templatefile("${path.module}/values/${v}", local.secrets) ]
}