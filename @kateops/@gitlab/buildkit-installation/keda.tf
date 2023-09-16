#locals {
#  keda_default = {
#    kind = "Deployment"
#  }
#}
#
#resource "kubectl_manifest" "buildkit" {
#  yaml_body = templatefile("${path.module}/keda/scaleobject.yaml", merge(local.keda_default, {
#    name = local.app
#    namespace: var.namespace
#  }))
#}
