locals {
  keda_default = {
    kind = "Deployment"
  }
}

resource "kubectl_manifest" "runner" {
  yaml_body = templatefile("${path.module}/keda/scaleobject.yaml", merge(local.keda_default, {
    name = "runner-${var.pressure}-gitlab-runner"
    namespace: var.namespace
  }))
}
