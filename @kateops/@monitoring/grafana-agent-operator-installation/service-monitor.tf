resource "kubectl_manifest" "service_monitor" {
  for_each = local.scaling
  yaml_body = each.value
}


locals {
  scaling_vars = {
    namespace = var.namespace
  }
  scaling = { for v in fileset("${path.module}/manifests","*"): v => templatefile("${path.module}/manifests/${v}", local.scaling_vars)}
}

