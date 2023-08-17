resource "gitlab_instance_variable" "vault_root_token" {
  key   = "TF_VAR_vault_root_token"
  value = var.vault_root_token
  masked = true
  protected = false
  variable_type = "env_var"
}


resource "gitlab_personal_access_token" "admin" {
  name   = "admin"
  user_id = data.gitlab_user.automation.user_id
  scopes = ["api", "write_repository", "write_registry", "admin_mode",]
}
resource "gitlab_instance_variable" "admin" {
  key   = "CI_PIPELINE_TOKEN"
  value = gitlab_personal_access_token.admin.token
  masked = true
  protected = false
  variable_type = "env_var"
}



resource "gitlab_personal_access_token" "registry" {
  name   = "registry-token"
  user_id = data.gitlab_user.automation.user_id
  scopes = ["read_registry",  "admin_mode", "read_api", "read_repository"]
}

resource "gitlab_personal_access_token" "registry_push" {
  name = "registry-push-token"
  user_id = data.gitlab_user.automation.user_id
  scopes = ["read_registry",  "admin_mode", "read_api", "read_repository", "write_registry", "api"]
}

resource "gitlab_instance_variable" "registry_push_token" {
  key   = "REGISTRY_PUSH_TOKEN"
  value = gitlab_personal_access_token.registry_push.token
  masked = true
}

resource "gitlab_instance_variable" "registry_push_user" {
  key   = "REGISTRY_PUSH_USER"
  value = data.gitlab_user.automation.username
}

resource "gitlab_instance_variable" "kube_config" {
  key   = "KUBECONFIG"
  value = var.kubeconfig
  variable_type = "file"
}

resource "gitlab_instance_variable" "vault_service_token" {
  key   = "VAULT_SERVICE_TOKEN"
  value = data.vault_generic_secret.vault_service_token.data["terraform"]
  variable_type = "file"
}

data "vault_generic_secret" "vault_service_token" {
  path = "admin/service"
}