locals {
  gitlab_domain = "gitlab.kateops.com"
  nextcloud_domain = "cloud.kateops.com"
  grafana_domain = "grafana.kateops.com"
  argo_domain = "argo.kateops.com"
  outline_domain = "outline.kateops.com"
  portainer_domain = "portainer.kateops.com"
  default_scopes = [
    "profile",
    "email",
    "acr",
    "web-origins",
    "roles"
  ]
}