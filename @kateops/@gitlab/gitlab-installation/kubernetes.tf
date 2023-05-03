resource "kubernetes_secret" "gitlab_s3_storage_credentials" {
  metadata {
    name = "s3-storage-credentials"
    namespace = var.namespace
  }
  data = {
    (var.secret_key_name): templatefile("${path.module}/data/s3.yaml", {
      access_key_id: aws_iam_access_key.runner.id
      secret_access_key: aws_iam_access_key.runner.secret
      region: var.region
      host: local.s3_default_host
    })
    (var.backup_secret_key_name): templatefile("${path.module}/data/s3cmd.s3cfg", {
      access_key_id: aws_iam_access_key.runner.id
      secret_access_key: aws_iam_access_key.runner.secret
      region: var.region
      host: local.s3_default_host
    })
  }
}

resource "kubernetes_secret" "gitlab_s3_registry_credentials" {
  metadata {
    name = "s3-registry-credentials"
    namespace = var.namespace
  }
  data = {
    (var.secret_key_name): templatefile("${path.module}/data/registry-s3.yaml", {
      access_key_id: aws_iam_access_key.runner.id
      secret_access_key: aws_iam_access_key.runner.secret
      region: var.region
      host: local.s3_default_host
      registry_bucket_name: aws_s3_bucket.this["gitlab-registry"].bucket
    })
  }
}

resource "kubernetes_secret" "gitlab_postgresql_secret" {
  metadata {
    name = "giltab-postgresql-secret"
    namespace = var.namespace
  }
  data = {
    (var.secret_key_name): var.rdbs.password
  }
}

resource "kubernetes_secret" "gitlab_shell_secret" {
  metadata {
    name = "gitlab-shell-secret"
    namespace = var.namespace
    labels = {
      app = "gitlab"
      heritage = "Helm"
      release = "gitlab"
    }
  }
  data = {
    (var.secret_key_name): random_password.gitlab_shell.result
  }
  lifecycle {
    ignore_changes = [
      metadata
    ]
  }
}


resource "kubernetes_secret" "smtp_secret" {
  metadata {
    name = "gitlab-smtp-secret"
    namespace = var.namespace
  }
  data = {
    (var.secret_key_name): module.ses.password
  }
}

resource "kubernetes_secret" "oidc_secret" {
  metadata {
    name = "gitlab-oidc-secret"
    namespace = var.namespace
  }
  data = {
    (var.secret_key_name): templatefile("${path.module}/data/oidc.yaml", {
      gitlab_oidc_client_id: data.vault_generic_secret.gitlab_oidc.data["id"]
      gitlab_oidc_client_secret: data.vault_generic_secret.gitlab_oidc.data["secret"]
      gitlab_host_domain: var.gitlab_domain_name
    })
  }
}

