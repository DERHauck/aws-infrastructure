provider "gitlab" {
  token = data.vault_generic_secret.gitlab_admin.data["token"]
  base_url = "https://gitlab.kateops.com"
}