module "homepage" {
  source = "./../../../module/gitlab/project"
  name = "Homepage"
  visibility = "internal"
  group_id = var.group_id
}

module "environment" {
  source = "./../../../module/gitlab/project"
  name = "Environment"
  visibility = "internal"
  group_id = var.group_id
}