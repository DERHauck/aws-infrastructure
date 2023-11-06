resource "gitlab_project" "this" {
  name = var.name
  path = replace(lower(var.name), " ", "-")
  description = var.description
  public_builds = var.visibility == "public" ? true : false
  remove_source_branch_after_merge = true
  shared_runners_enabled = true
  visibility_level = var.visibility
  wiki_enabled = false
  wiki_access_level = "disabled"
  allow_merge_on_skipped_pipeline = false
  autoclose_referenced_issues = true
  issues_enabled = true
  merge_pipelines_enabled = false
  merge_trains_enabled = false
  ci_separated_caches = false
  only_allow_merge_if_pipeline_succeeds = true
  only_allow_merge_if_all_discussions_are_resolved = true
  namespace_id = var.group_id
}

resource "gitlab_branch_protection" "this" {
  branch             = "main"
  merge_access_level = "developer"
  project            = gitlab_project.this.id
  push_access_level  = "no one"
  unprotect_access_level = "maintainer"
  allowed_to_push {
    user_id = 1
  }
  allow_force_push = true
}

data "gitlab_group" "this" {
  group_id = var.group_id
}

resource "gitlab_repository_file" "argo" {
  branch         = gitlab_project.this.default_branch
  commit_message = "use argo"
  content        = ""
  file_path      = ".argo/.gitkeep"
  project        = gitlab_project.this.id
  depends_on = [
    gitlab_branch_protection.this
  ]
}