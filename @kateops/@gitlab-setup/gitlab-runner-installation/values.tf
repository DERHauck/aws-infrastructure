locals {
  labels = {
    "type/pressure" = var.pressure
  }
  vars = {
    concurrency: var.concurrency
    s3_connection_secret_name: kubernetes_secret.gitlab_s3_storage_credentials.metadata[0].name
    region: var.region
    s3_cache_bucket_name: var.s3_cache_bucket_name
    s3_default_host: var.s3_default_host
    pressure: var.pressure
    node_selector = local.labels
    image_pull_secret = var.image_pull_secret

    memory_limit = var.memory_limit
    cpu_limit = var.cpu_limit
    helper_memory_limit = var.helper_memory_limit
    helper_cpu_limit = var.helper_cpu_limit
    service_cpu_limit = var.service_cpu_limit
    service_memory_limit = var.service_memory_limit


  }
  secrets = {
    registration_token: var.registration_token
  }
  templates_secret = [ for v in fileset("${path.module}/values","*.yml"): templatefile("${path.module}/values/${v}", local.secrets) ]
  templates_raw = [ for v in fileset("${path.module}/values","*.yaml"): templatefile("${path.module}/values/${v}", local.vars) ]
  templates = concat(local.templates_raw, local.templates_secret)
}