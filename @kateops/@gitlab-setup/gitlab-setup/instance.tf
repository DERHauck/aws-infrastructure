resource "gitlab_instance_variable" "vault_root_token" {
  key   = "TF_VAR_vault_root_token"
  value = var.vault_root_token
  masked = true
  protected = false
  variable_type = "env_var"
}
