
locals {
  vars = {
    nextcloud_secret_name: kubernetes_secret.nextcloud_secret.metadata[0].name
    monitoring_namespace: var.monitoring_namespace
    host_domain: var.host_domain

    usernameKey = local.usernameKey
    passwordKey = local.passwordKey
    tokenKey = local.tokenKey
    smtpUsernameKey = local.smtpUsernameKey
    smtpPasswordKey = local.smtpPasswordKey

    redis_host = local.redis_host
    redis_port = local.redis_port
    redis_password = local.redis_password
    redis_secret_name = kubernetes_secret.nextcloud_redis.metadata[0].name

    oidc_secret_name = kubernetes_secret.nextcloud_oidc.metadata[0].name
    oidc_secret = local.oidc_secret
    oidc_id = local.oidc_id

    s3_access = local.s3_access
    s3_secret = local.s3_secret
    s3_secret_name = kubernetes_secret.nextcloud_s3.metadata[0].name
    bucket_host = "s3.amazonaws.com"
    bucket_name = aws_s3_bucket.this.id
    region = var.region
    claim_name = kubernetes_persistent_volume_claim.this.metadata[0].name


    postgres_secret_name = kubernetes_secret.nextcloud_postgres.metadata[0].name
  }
  secrets = {
    smtp_host = module.ses.host

    postgres_secret_name = kubernetes_secret.nextcloud_postgres.metadata[0].name
    pq_host = var.rdbs.host
    pq_port = var.rdbs.port
    pq_username = local.postgres_username
    pq_password = local.postgres_password
    pq_db = var.rdbs.database

  }

  templates = [ for v in fileset("${path.module}/values","*.yaml"): templatefile("${path.module}/values/${v}", local.vars) ]
  secret_templates =  [ for v in fileset("${path.module}/values","*.yml"): templatefile("${path.module}/values/${v}", local.secrets) ]
}