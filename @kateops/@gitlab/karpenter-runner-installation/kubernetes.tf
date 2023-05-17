locals {
  labels = {
    "type/gitlab-runner" = "default"
  }
}
resource "kubectl_manifest" "this" {
  yaml_body = templatefile("${path.module}/provisioner.karpenter.yaml", {
    labels = local.labels
  })
}
