resource "kubernetes_secret" "nextcloud_secret" {
  metadata {
    name = "${var.helm_name}-password"
    namespace = var.namespace
  }
  data = {
    (local.passwordKey): random_password.password.result
    (local.usernameKey): "admin"
    (local.tokenKey): random_password.password.result
    (local.smtpUsernameKey): var.smtp_username
    (local.smtpPasswordKey): var.smtp_password
  }
}

resource "kubernetes_secret" "nextcloud_redis" {
  metadata {
    name = "${var.helm_name}-redis"
    namespace = var.namespace
  }
  data = {
    (local.redis_password): var.redis_password
    (local.redis_port): var.redis_port
    (local.redis_host): var.redis_host
  }
}


resource "kubernetes_secret" "nextcloud_postgres" {
  metadata {
    name = "${var.helm_name}-postgres"
    namespace = var.namespace
  }
  data = {
    (local.postgres_host): var.rdbs.host
    (local.postgres_port): var.rdbs.port
    (local.postgres_username): var.rdbs.username
    (local.postgres_password): var.rdbs.password
    (local.postgres_database): var.rdbs.database
  }
}

resource "kubernetes_secret" "nextcloud_oidc" {
  metadata {
    name = "nextcloud-oidc"
    namespace = var.namespace
  }
  data = {
    (local.oidc_id) = var.oidc_id
    (local.oidc_secret) = var.oidc_secret
  }
}

resource "kubernetes_secret" "nextcloud_s3" {
  metadata {
    name = "nextcloud-s3"
    namespace = var.namespace
  }
  data = {
    (local.s3_access) = aws_iam_access_key.nextcloud.id
    (local.s3_secret) = aws_iam_access_key.nextcloud.secret
  }
}