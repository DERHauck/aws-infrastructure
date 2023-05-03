module "dashboard" {
  source = "./dashboard-installation"
  namespace = kubernetes_namespace.this.metadata[0].name
  host_domain = "dashboard.kateops.com"
  is_admin = true
  service_account_name = "octant-k8ps"
}


module "dashboard-openproxy" {
  source = "../../module/cluster/openproxy"
  namespace = kubernetes_namespace.this.metadata[0].name

  oidc_id     = data.vault_generic_secret.dashboard_oidc.data["id"]
  oidc_secret = data.vault_generic_secret.dashboard_oidc.data["secret"]
  sub_domain  = "dashboard"
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

#module "dashboard-admin" {
#  source = "./dashboard-installation"
#  namespace = kubernetes_namespace.this.metadata[0].name
#  host_domain = "admin.dashboard.kateops.com"
#  is_admin = true
#  service_account_name = "cluster-admin"
#}
#
#
#module "dashboard-admin-openproxy" {
#  source = "../tf_monitoring/openproxy-installation"
#  namespace = kubernetes_namespace.this.metadata[0].name
#
#  oidc_id     = data.vault_generic_secret.dashboard_oidc.data["id"]
#  oidc_secret = data.vault_generic_secret.dashboard_oidc.data["secret"]
#  sub_domain  = "admin.dashboard"
#  allowed_role = "admin"
#}