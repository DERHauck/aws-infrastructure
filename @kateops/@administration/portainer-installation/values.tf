locals {
  vars = {
    host_domain: var.host_domain
  }
  templates = [ for v in fileset("${path.module}/values","*"): templatefile("${path.module}/values/${v}", local.vars) ]
  secret_templates = [] # [ for v in fileset("${path.module}/values","*.yml"): templatefile("${path.module}/values/${v}", local.secrets) ]
}