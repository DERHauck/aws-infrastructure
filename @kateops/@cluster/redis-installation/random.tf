resource "random_password" "password" {
  length = 16
  numeric = true
  special = false
  upper = true
  lower = true
}