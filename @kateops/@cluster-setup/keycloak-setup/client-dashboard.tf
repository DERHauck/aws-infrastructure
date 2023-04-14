module "dashboard" {
  source = "./openproxy-client"
  client_name = "dashboard"
  sub_domain = "dashboard"
  realm = data.keycloak_realm.master.id
}
