module "opencost" {
  source = "./openproxy-client"
  client_name = "Opencost"
  sub_domain = "opencost"
  realm = data.keycloak_realm.master.id
}