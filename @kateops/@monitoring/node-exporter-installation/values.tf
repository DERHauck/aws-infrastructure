locals {
  vars = {
    namespace = var.namespace


  }
  templates = [ for v in fileset("${path.module}/values","*.yml"): templatefile("${path.module}/values/${v}", local.vars) ]
}