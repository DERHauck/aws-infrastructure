output "keycloak_admin_password" {
  value     = random_password.keycloak_admin_password.result
  sensitive = true
}

output "keycloak_admin_username" {
  value = var.keycloak_admin_username
}
