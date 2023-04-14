resource "random_password" "gitlab_shell" {
  length = 13
  numeric = true
  special = true
  upper = true
  lower = true
}