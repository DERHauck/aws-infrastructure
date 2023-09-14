resource "kubectl_manifest" "karpenter" {
  yaml_body = templatefile("${path.module}/karpenter/provisioner.karpenter.yaml", {
    labels = {
      "type/gitlab-runner" = "buildkit"
    }
  })
}
