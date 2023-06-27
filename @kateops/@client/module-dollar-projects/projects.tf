module "homepage" {
  source = "./../../../module/gitlab/project"
  name = "Dollar"
  visibility = "internal"
  group_id = var.group_id
}
