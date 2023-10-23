locals {
  vars = {
    postgresql_host : local.db_host
    postgresql_port : local.db_port
    postgresql_username : local.db_user
    postgresql_database : local.db_name
    keycloak_admin_username : var.keycloak_admin_username
  }
  templates = [for v in fileset("${path.module}/values", "*.yaml") : templatefile("${path.module}/values/${v}", local.vars)]
}