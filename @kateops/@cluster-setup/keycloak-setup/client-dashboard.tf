module "dashboard" {
  source = "./openproxy-client"
  client_name = "dashboard"
  sub_domain = "dashboard"
  realm = keycloak_realm.master.id
}
