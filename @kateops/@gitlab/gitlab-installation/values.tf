
locals {
  vars = {
    secret_key_name: var.secret_key_name
    postgresql_password_secret_name: kubernetes_secret.gitlab_postgresql_secret.metadata[0].name,
    backup_secret_key_name: var.backup_secret_key_name
    gitlab_host_domain: var.gitlab_host_domain
    gitlab_domain_name: var.gitlab_domain_name
    gitlab_registry_domain_name: var.gitlab_registry_domain_name
    shell_password_secret_name: kubernetes_secret.gitlab_shell_secret.metadata[0].name
    pages_host: var.pages_host
    s3_connection_secret_name: kubernetes_secret.gitlab_s3_storage_credentials.metadata[0].name
    default_region: var.region
    s3_connection_registry_secret_name: kubernetes_secret.gitlab_s3_registry_credentials.metadata[0].name
    registry_bucket_name: aws_s3_bucket.this["gitlab-registry"].id
    smtp_password_secret_name: kubernetes_secret.smtp_secret.metadata[0].name
    pages_bucket_name: aws_s3_bucket.this["gitlab-pages"].id
    backups_bucket_name: aws_s3_bucket.this["gitlab-backup"].id
    backups_tmp_bucket_name: aws_s3_bucket.this["gitlab-backup-tmp"].id
    artifacts_bucket_name: aws_s3_bucket.this["gitlab-artifacts"].id
    uploads_bucket_name: aws_s3_bucket.this["gitlab-uploads"].id
    packages_bucket_name:  aws_s3_bucket.this["gitlab-packages"].id
    terraform_bucket_name: aws_s3_bucket.this["gitlab-state"].id
    lfs_bucket_name: aws_s3_bucket.this["gitlab-lfs"].id
    dependency_proxy_bucket_name: aws_s3_bucket.this["gitlab-dependency-proxy"].id
    email_display_name: local.email_display_name
    email_reply_to: local.email_from_address
    email_from_address: local.email_from_address
    redis_host: var.redis_host
    storage_class: var.storage_class
    oidc_provider_secret: kubernetes_secret.oidc_secret.metadata[0].name
    #redis_secret_name: kubernetes_secret.redis_secret.metadata[0].name
    #redis_secret_key: var.secret_key_name
  }
  secrets= {
    postgresql_host: var.rdbs.host
    postgresql_port: var.rdbs.port
    postgresql_username: var.rdbs.username
    postgresql_database: var.rdbs.database
    smtp_address: var.smtp_host
    smtp_user_name: var.smtp_username
  }
  open_templates = [for v in fileset("${path.module}/values","*.yaml"): templatefile("${path.module}/values/${v}", local.vars)]
  secret_templates = [for v in fileset("${path.module}/values","*.yml"): templatefile("${path.module}/values/${v}", local.secrets)]
  templates = concat(local.secret_templates, local.open_templates)
}