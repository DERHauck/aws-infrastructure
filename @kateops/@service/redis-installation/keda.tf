locals {
  keda_default = {
    kind = "Deployment"
  }
}

resource "kubectl_manifest" "master" {
  yaml_body = templatefile("${path.module}/keda/scaleobject.yaml", merge(local.keda_default, {
    name = "redis-master"
    namespace: var.namespace
    kind = "StatefulSet"
  }))
}

resource "kubectl_manifest" "replicas" {
  yaml_body = templatefile("${path.module}/keda/scaleobject.yaml", merge(local.keda_default, {
    name = "redis-replicas"
    namespace: var.namespace
    kind = "StatefulSet"
  }))
}