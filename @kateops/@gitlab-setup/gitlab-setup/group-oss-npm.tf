resource "gitlab_group" "oss_npm" {
  name = "NPM"
  path = "npm"
  visibility_level = "public"
  default_branch_protection = 3
  request_access_enabled = true
  parent_id = module.oss.group_id
}


module "ktc_types" {
  source = "./project-public"
  name = "KTC-Types"
  description = "Types so the KTC service can generate Gitlab pipelines"
  group_id = gitlab_group.oss_npm.id
}