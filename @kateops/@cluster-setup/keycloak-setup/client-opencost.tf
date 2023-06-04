module "opencost" {
  source = "./openproxy-client"
  client_name = "Opencost"
  sub_domain = "opencost"
  realm = keycloak_realm.master.id
}