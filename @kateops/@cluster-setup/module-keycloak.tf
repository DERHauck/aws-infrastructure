module "keycloak_setup" {
  source = "./keycloak-setup"

  depends_on = [
    module.vault_setup
  ]
}