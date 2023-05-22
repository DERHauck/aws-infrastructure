module "nextcloud" {
  source    = "./nextcloud-installation"
  namespace = kubernetes_namespace.this.metadata[0].name

  helm_name            = "nextcloud"
  monitoring_namespace = "monitoring"
  host_domain          = "cloud.kateops.com"

  redis_host     = module.redis.host-master
  redis_port     =  module.redis.port
  redis_password = module.redis.password
  efs_id = module.rs_kateops.outputs.clusters.production.efs_id
  oidc_id = data.vault_generic_secret.nextcloud_oidc.data["id"]
  oidc_secret = data.vault_generic_secret.nextcloud_oidc.data["secret"]
  rdbs = module.nextcloud_db
}

module "nextcloud_db" {
  source = "../../module/terraform/default-rds"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  database = "nextcloud_db"
  state_name = "kateops"
  username = "nextcloud_user"
}