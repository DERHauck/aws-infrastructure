locals {
  vars = {
    redis_secret_name: kubernetes_secret.redis_secret.metadata[0].name
    redis_secret_key: local.password_secret_key
    monitoring_namespace: var.monitoring_namespace
  }
  templates = [ for v in fileset("${path.module}/values","*"): templatefile("${path.module}/values/${v}", local.vars) ]
  secret_templates = [] # [ for v in fileset("${path.module}/values","*.yml"): templatefile("${path.module}/values/${v}", local.secrets) ]
}