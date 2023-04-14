output "runner_access_key_id" {
  value = aws_iam_access_key.runner.id
}

output "runner_access_key_secret" {
  value = aws_iam_access_key.runner.secret
}

output "runner_registration_token" {
  value = data.kubernetes_secret.runner_token.data["runner-registration-token"]
}

output "runner_bucket" {
  value = aws_s3_bucket.this["gitlab-cache"].bucket
}