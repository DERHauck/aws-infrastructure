resource "gitlab_group" "infrastructure" {
  name = "Infrastructure"
  path = "infrastructure"
  visibility_level = "internal"
}

#output "url" {
#  value = gitlab_group.infrastructure.web_url
#}

module "infrastructure_labels" {
  source = "./default-labels"
  group_id = gitlab_group.infrastructure.id
}