module "gitlab" {
  source = "./gitlab-installation"

  namespace = kubernetes_namespace.gitlab.metadata[0].name

  region             = local.default_region
  access_key_id      = var.aws_access_key
  secret_access_key  = var.aws_secret_key
  redis_host         = data.vault_generic_secret.redis.data.host-master
  redis_password     = data.vault_generic_secret.redis.data.password
  cluster_issuer_arn = local.oidc_issuer_arn
  cluster_issuer     = local.oidc_issuer
}
