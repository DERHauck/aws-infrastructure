module "homepage" {
  source = "./../../../module/gitlab/project"
  name = "Homepage"
  visibility = "internal"
  group_id = var.group_id
}