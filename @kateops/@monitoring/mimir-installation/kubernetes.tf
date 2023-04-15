resource "kubernetes_secret" "bucket_secret" {
  metadata {
    namespace = var.namespace
    name      = "s3-credentials-mimir"
  }

  data = {
    (var.secret_key_name) : aws_iam_access_key.mimir.secret
    (var.access_key_name) : aws_iam_access_key.mimir.id
  }
}

resource "kubernetes_secret" "env_secret" {
  metadata {
    name = "mimir-env-from-secret"
    namespace = var.namespace
  }
  data = {
    (var.secret_key_name) : aws_iam_access_key.mimir.secret
    (var.access_key_name) : aws_iam_access_key.mimir.id
  }
}