resource "gitlab_project" "this" {
  name = var.name
  description = var.description
  public_builds = false
  remove_source_branch_after_merge = true
  shared_runners_enabled = true
  visibility_level = "public"
  wiki_enabled = false
  wiki_access_level = "disabled"
  allow_merge_on_skipped_pipeline = false
  autoclose_referenced_issues = true
  issues_enabled = true
  merge_pipelines_enabled = false
  merge_trains_enabled = false
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
}