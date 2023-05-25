module "opencost" {
  source = "./opencost-installation"
  namespace = kubernetes_namespace.this.metadata[0].name

  host_domain = "opencost.kateops.com"
  fqdn_prometheus_service = "http://mimir-nginx:80"
  grafana_service = "grafana-default:80"
  storage_class = "efs-sc"
}

module "opencost-openproxy" {
  source = "../../module/cluster/openproxy"
  namespace = kubernetes_namespace.this.metadata[0].name

  oidc_id     = data.vault_generic_secret.opencost_oidc.data["id"]
  oidc_secret = data.vault_generic_secret.opencost_oidc.data["secret"]
  sub_domain  = "opencost"
  redis_secret_name = kubernetes_secret.redis_password.metadata[0].name
  redis_endpoint = module.rs_kateops.outputs.elasticache.address
}
resource "kubernetes_secret" "redis_password" {
  metadata {
    name = "redis-password"
    namespace = kubernetes_namespace.this.metadata[0].name
  }
  data = {
    redis-password: ""
  }
}
