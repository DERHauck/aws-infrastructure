resource "kubernetes_secret" "gitlab_s3_storage_credentials" {
  metadata {
    name = "s3-cache-storage-credentials-runner-${var.pressure}"
    namespace = var.namespace
  }
  data = {
    accesskey: var.access_key
    secretkey: var.secret_key
  }
}


resource "kubectl_manifest" "this" {
  yaml_body = templatefile("${path.module}/provisioner.karpenter.yaml", {
    pressure = var.pressure
    labels = local.labels
  })
}
