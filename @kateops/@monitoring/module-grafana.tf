module "grafana" {
  source = "./grafana-installation"
  namespace = kubernetes_namespace.this.metadata[0].name

  host_domain = "grafana.kateops.com"
  oidc_secret = data.vault_generic_secret.grafana_oidc  .data["secret"]
  oidc_id = data.vault_generic_secret.grafana_oidc.data["id"]
  helm_name = "grafana-default"

  depends_on = [
    module.keda,
  ]
}