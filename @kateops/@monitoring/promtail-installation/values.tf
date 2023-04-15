locals {
  vars = {
    tenant_id: var.tenant_id
  }
  templates = [ for v in fileset("${path.module}/values","*.yaml"): templatefile("${path.module}/values/${v}", local.vars) ]
}