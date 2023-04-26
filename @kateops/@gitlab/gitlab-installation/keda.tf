locals {
  keda_default = {
    kind = "Deployment"
  }
}

resource "kubectl_manifest" "webservice" {
  yaml_body = templatefile("${path.module}/keda/scaleobject.yaml", merge(local.keda_default, {
    name = "gitlab-webservice-default"
    namespace: var.namespace
  }))
}

resource "kubectl_manifest" "toolbox" {
  yaml_body = templatefile("${path.module}/keda/scaleobject.yaml", merge(local.keda_default, {
    name = "gitlab-toolbox"
    namespace: var.namespace
  }))
}

resource "kubectl_manifest" "gitaly" {
  yaml_body = templatefile("${path.module}/keda/scaleobject.yaml", merge(local.keda_default, {
    name = "gitlab-gitaly"
    namespace: var.namespace
    kind = "StatefulSet"
  }))
}


resource "kubectl_manifest" "sidekiq" {
  yaml_body = templatefile("${path.module}/keda/scaleobject.yaml", merge(local.keda_default, {
    name = "gitlab-sidekiq-all-in-1-v2"
    namespace: var.namespace
  }))
}