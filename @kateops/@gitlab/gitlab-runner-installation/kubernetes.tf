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
