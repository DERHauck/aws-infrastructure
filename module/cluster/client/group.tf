resource "gitlab_group" "this" {
  name = var.name
  path = local.sanitized_name
  visibility_level = var.visibility
  default_branch_protection = 3
  request_access_enabled = true
}

resource "time_rotating" "rotate" {
  rotation_months = 2
}

resource "gitlab_group_variable" "vault_service_token" {
  group = gitlab_group.this.id
  key   = "VAULT_SERVICE_TOKEN"
  value = vault_token.terraform_service_token.client_token
  variable_type = "env_var"
}

resource "gitlab_group_access_token" "this" {
  group        = gitlab_group.this.id
  name         = "Service Token"
  access_level = "maintainer"
  expires_at = formatdate("YYYY-MM-DD" ,time_rotating.rotate.rotation_rfc3339)
  scopes = [
    "api",
    "read_registry",
    "write_registry",
  ]
}
resource "gitlab_group_access_token" "argo" {
  group        = gitlab_group.this.id
  name         = "Argo"
  access_level = "maintainer"
  expires_at = formatdate("YYYY-MM-DD" ,time_rotating.rotate.rotation_rfc3339)
  scopes = [
    "read_repository",
    "write_repository",
    "read_api",
    "api",
  ]
}

resource "gitlab_group_label" "version_patch" {
  color = "#36454f"
  group = gitlab_group.this.id
  name  = "version::patch"
  description = "patch version increase"
}
resource "gitlab_group_label" "version_minor" {
  color = "#8080af"
  group = gitlab_group.this.id
  name  = "version::minor"
  description = "minor version increase"
}
resource "gitlab_group_label" "version_major" {
  color = "#808090"
  group = gitlab_group.this.id
  name  = "version::major"
  description = "major version increase"
}

resource "vault_generic_secret" "docker_base_service_token" {
  path      = "${vault_mount.this.path}/gitlab/service"
  data_json = jsonencode({
    token: gitlab_group_access_token.this.token
  })
}

resource "vault_generic_secret" "kubeconfig" {
  path      = "${vault_mount.this.path}/kubernetes/production"
  data_json = jsonencode({
    KUBECONFIG = module.service-account-cicd.kubeconfig
  })
}

resource "gitlab_group_variable" "kubernetes" {
  group = gitlab_group.this.id
  key   = "KUBECONFIG"
  variable_type = "file"
  value = module.service-account-cicd.kubeconfig
}