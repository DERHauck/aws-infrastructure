locals {
  sanitized_name = replace(lower(var.name), " ", "-")
  realm_id = "master"
  gitlab_project_url = "https://gitlab.kateops.com/${gitlab_group.this.full_path}"
  argo_manifests_path = "${path.module}/argo-manifests"
}