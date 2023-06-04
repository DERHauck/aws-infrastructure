module "prometheus" {
  source = "./openproxy-client"
  client_name = "Prometheus"
  sub_domain = "prometheus"
  realm = keycloak_realm.master.id
}
