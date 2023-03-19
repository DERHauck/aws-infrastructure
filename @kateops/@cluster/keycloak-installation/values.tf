locals {
  vars = {
    postgresql_host : var.rdbs.host
    postgresql_port : var.rdbs.port
    postgresql_username : var.rdbs.username
    postgresql_database : var.rdbs.database
    keycloak_admin_username : var.keycloak_admin_username
  }
  templates = [for v in fileset("${path.module}/values", "*.yaml") : templatefile("${path.module}/values/${v}", local.vars)]
}