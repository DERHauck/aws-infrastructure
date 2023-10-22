locals {
  db_secret_list = split(":",data.kubernetes_secret.keycloak-cluster-app.data["pgpass"])
  db_host = nonsensitive(local.db_secret_list[0])
  db_port = nonsensitive(local.db_secret_list[1])
  db_name = nonsensitive(local.db_secret_list[2])
  db_user = nonsensitive(local.db_secret_list[3])
  db_password = data.kubernetes_secret.keycloak-cluster-app.data["password"]
  vars = {
    postgresql_host : local.db_host
    postgresql_port : local.db_port
    postgresql_username : local.db_user
    postgresql_database : local.db_name
    keycloak_admin_username : var.keycloak_admin_username
  }
  templates = [for v in fileset("${path.module}/values", "*.yaml") : templatefile("${path.module}/values/${v}", local.vars)]
}