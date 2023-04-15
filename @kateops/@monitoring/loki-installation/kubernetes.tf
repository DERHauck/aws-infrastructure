resource "kubernetes_secret" "bucket_secret" {
  metadata {
    namespace = var.namespace
    name      = "s3-credentials-loki"
  }

  data = {
    (var.secret_key_name) : aws_iam_access_key.loki.secret
    (var.access_key_name) : aws_iam_access_key.loki.id
  }
}
