
provider "keycloak" {
  client_id = "admin-cli"
  username = module.rs_cluster.outputs.keycloak.keycloak_admin_username
  password =   module.rs_cluster.outputs.keycloak.keycloak_admin_password
  url       = "https://sso.kateops.com"
  base_path = ""
}
