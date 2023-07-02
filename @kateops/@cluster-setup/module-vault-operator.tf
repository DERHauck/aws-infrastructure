module "vault-operator-installation" {
  source = "./vault-operator-installation"
  vault_service = "https://vault.kateops.com" # "http://vault-active.security.svc:8200"
  namespace = "security"
  depends_on = [
    module.vault_setup
  ]
}