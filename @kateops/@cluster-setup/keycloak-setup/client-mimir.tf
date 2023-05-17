module "mimir" {
  source = "./openproxy-client"
  client_name = "Mimir"
  sub_domain = "mimir"
  realm = data.keycloak_realm.master.id
}
