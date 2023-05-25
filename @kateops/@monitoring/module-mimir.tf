module "mimir" {
  source = "./mimir-installation"

  namespace = kubernetes_namespace.this.metadata[0].name
  host_domain = "mimir.kateops.com"
  tenant_ids = ["kateops"]
}

module "mimir-openproxy" {
  source = "../../module/cluster/openproxy"
  namespace = kubernetes_namespace.this.metadata[0].name

  oidc_id     = data.vault_generic_secret.mimir_oidc.data["id"]
  oidc_secret = data.vault_generic_secret.mimir_oidc.data["secret"]
  sub_domain  = "mimir"
  redis_secret_name = kubernetes_secret.redis_password.metadata[0].name
  redis_endpoint = module.rs_kateops.outputs.elasticache.address
}