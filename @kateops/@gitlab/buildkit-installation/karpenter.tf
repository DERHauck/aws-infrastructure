locals {
  labels = {
    "type/gitlab-runner" = "buildkit"
  }
}
resource "kubectl_manifest" "buildkit" {
  yaml_body = templatefile("${path.module}/buildkit/provsioner.karpenter.yaml", {
    labels = local.labels
  })
}
