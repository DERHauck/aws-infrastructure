
provider "keycloak" {
  client_id = "admin-cli"
  username = data.vault_generic_secret.keycloak.data["username"]
  password =   data.vault_generic_secret.keycloak.data["password"]
  url       = "https://sso.kateops.com"
  base_path = ""
}
