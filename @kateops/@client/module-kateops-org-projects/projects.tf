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


module "infrastructure" {
  source = "./../../../module/gitlab/project"
  name = "Infrastructure"
  visibility = "internal"
  group_id = var.group_id
}

module "Services" {
  source = "./../../../module/gitlab/project"
  name = "Services"
  visibility = "internal"
  group_id = var.group_id
}