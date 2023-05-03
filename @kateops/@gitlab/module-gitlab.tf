module "gitlab" {
  source = "./gitlab-installation"

  namespace   = kubernetes_namespace.gitlab.metadata[0].name

  region                     = local.default_region
  access_key_id              = var.aws_access_key
  secret_access_key          = var.aws_secret_key
  redis_host                 = module.rs_kateops.outputs.elasticache.address
  rdbs = module.gitlab_db
  cluster_issuer_arn         = local.oidc_issuer_arn
  cluster_issuer = local.oidc_issuer
}

module "gitlab_db" {
  source = "../../module/terraform/default-rds"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  database = "gitlab_db"
  state_name = "kateops"
  username = "gitlab_user"
}