module "feedback-api" {
  source = "./../../../module/gitlab/project"
  name = "Feedback API"
  visibility = "internal"
  group_id = var.group_id
}