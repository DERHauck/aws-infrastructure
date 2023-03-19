output "host" {
  value = local.host
}

output "port" {
  value = local.port
}

output "database" {
  value = postgresql_schema.this.name
}

output "username" {
  value = postgresql_role.this.name
}

output "password" {
  value = postgresql_role.this.password
}