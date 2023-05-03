resource "vault_generic_secret" "gitlab" {
  path      = "kateops/gitlab/runner"
  data_json = jsonencode({
    access_key = aws_iam_access_key.runner.id
    secret_key = aws_iam_access_key.runner.secret
    registration_token = data.kubernetes_secret.runner_token.data["runner-registration-token"]
    s3_cache_bucket_name = aws_s3_bucket.this["gitlab-cache"].bucket
    namespace = var.namespace
  })
}