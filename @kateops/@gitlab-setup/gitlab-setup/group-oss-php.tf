resource "gitlab_group" "oss_php" {
  name = "PHP"
  path = "php"
  visibility_level = "public"
  default_branch_protection = 3
  request_access_enabled = true
}


module "php_slim" {
  source = "./project-public"
  name = "Slim"
  description = "Slim Framework Setup"
  group_id = gitlab_group.oss_php.id
}