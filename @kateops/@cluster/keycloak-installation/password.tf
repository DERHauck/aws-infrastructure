resource "random_password" "keycloak_admin_password" {
  length  = 10
  numeric = true
  lower   = true
  upper   = true
}

resource "random_password" "keycloak_management_password" {
  length  = 10
  numeric = true
  lower   = true
  upper   = true
}
