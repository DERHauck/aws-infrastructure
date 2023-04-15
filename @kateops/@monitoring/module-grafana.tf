module "grafana" {
  source = "./grafana-installation"
  namespace = kubernetes_namespace.this.metadata[0].name

  host_domain = "grafana.kateops.com"
  oidc_secret = data.vault_generic_secret.grafana_oidc  .data["secret"]
  oidc_id = data.vault_generic_secret.grafana_oidc.data["id"]
  helm_name = "grafana-default"
  gf_smtp_password = ""
  gf_smtp_username = ""
  gf_smtp_host = ""
  rdbs = module.grafana_db

  depends_on = [
    module.keda,
  ]
}


module "grafana_db" {
  source = "../../module/terraform/default-rds"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  database = "grafana_db"
  state_name = "kateops"
  username = "grafana_user"
}
