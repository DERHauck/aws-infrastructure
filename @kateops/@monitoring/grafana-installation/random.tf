resource "random_password" "admin" {
  length = 16
  numeric = true
  special = false
  upper = true
  lower = true
}

resource "random_string" "user" {
  length = 9
  numeric = false
  special = false
  upper = false
  lower = true
}