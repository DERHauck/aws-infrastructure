output "keycloak" {
  value = module.keycloak
  sensitive = true
}

output "redis" {
  value = module.redis
  sensitive = true
}