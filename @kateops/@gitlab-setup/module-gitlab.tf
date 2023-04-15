module "gitlab" {
  source = "./gitlab-setup"
  vault_root_token = var.vault_root_token
}