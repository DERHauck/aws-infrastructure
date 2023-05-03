resource "gitlab_instance_variable" "vault_root_token" {
  key   = "TF_VAR_vault_root_token"
  value = var.vault_root_token
  masked = true
  protected = false
  variable_type = "env_var"
}

resource "gitlab_personal_access_token" "registry" {
  name   = "registry-token"
  user_id = data.gitlab_user.automation.user_id
  scopes = ["read_registry",  "admin_mode", "read_api", "read_repository"]
}