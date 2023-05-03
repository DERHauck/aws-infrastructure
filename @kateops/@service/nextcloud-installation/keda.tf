resource "kubectl_manifest" "keda" {
  for_each = local.scaling
  yaml_body = each.value
}


locals {
  scaling_vars = {
    name = local.name
    namespace: var.namespace
  }
  scaling = { for v in fileset("${path.module}/keda","*"): v => templatefile("${path.module}/keda/${v}", local.scaling_vars)}
}