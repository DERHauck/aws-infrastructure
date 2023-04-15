locals {
  s3_endpoint = "s3.${var.region}.amazonaws.com"
  vars = {
    mimir_env_secret_name: kubernetes_secret.bucket_secret.metadata[0].name
    region: var.region
    host_domain: var.host_domain
    storage_class: var.storage_class
    s3_credentials_name: kubernetes_secret.bucket_secret.metadata[0].name
    secret_key_name: var.secret_key_name
    access_key_name: var.access_key_name
    s3_endpoint: local.s3_endpoint
    s3_bucket_name: aws_s3_bucket.this.bucket
    s3_bucket_region: aws_s3_bucket.this.region
  }
  templates = [ for v in fileset("${path.module}/values","*.yaml"): templatefile("${path.module}/values/${v}", local.vars) ]
}