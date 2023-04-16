
provider "grafana" {
  url = "https://grafana.kateops.com"
  auth = "${data.vault_generic_secret.grafana_admin.data["username"]}:${data.vault_generic_secret.grafana_admin.data["password"]}"
}