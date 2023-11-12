
resource "kubectl_manifest" "argo_project" {
  yaml_body = templatefile("${local.argo_manifests_path}/project.yaml", {
    namespace     = kubernetes_namespace.this.metadata[0].name
    name = local.sanitized_name
    gitlab_project_url = local.gitlab_project_url
  })
}

resource "gitlab_project" "argo_project" {
  name = "Argo Infrastructure"
  path = "argo"
  description = "Argo Infrastructure for ${var.name}"
  public_jobs = var.visibility == "public" ? true : false
  remove_source_branch_after_merge = true
  shared_runners_enabled = false
  visibility_level = var.visibility
  wiki_enabled = false
  wiki_access_level = "disabled"
  allow_merge_on_skipped_pipeline = false
  autoclose_referenced_issues = true
  issues_enabled = false
  merge_pipelines_enabled = false
  merge_trains_enabled = false
  ci_separated_caches = false
  only_allow_merge_if_pipeline_succeeds = false
  only_allow_merge_if_all_discussions_are_resolved = true
  namespace_id = gitlab_group.this.id
}

resource "gitlab_branch_protection" "argo_project" {
  branch             = "main"
  merge_access_level = "maintainer"
  project            = gitlab_project.argo_project.id
  unprotect_access_level = "maintainer"
  push_access_level = "maintainer"
  allow_force_push = true
}

resource "kubernetes_secret" "argo_project" {
  metadata {
    name = "repo-${replace(gitlab_project.argo_project.path_with_namespace, "/", "-")}"
    namespace = "argo"
    labels = {
      "argocd.argoproj.io/secret-type": "repository"
    }
  }
  data = {
    type = "git"
    url = gitlab_project.argo_project.http_url_to_repo
  }
}