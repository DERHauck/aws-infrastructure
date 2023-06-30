locals {
  vars = {
  }
  templates = [for v in fileset("${path.module}/values", "*.yaml") : templatefile("${path.module}/values/${v}", local.vars)]
}