resource "kubectl_manifest" "database" {
  yaml_body = templatefile("${path.module}/database.yaml", {
    namespace = var.namespace
  })
}

data "kubernetes_secret" "cnpg" {
  metadata {
    name = "gitlab-psql-cluster-app"
    namespace = var.namespace
  }
  depends_on = [
    kubectl_manifest.database
  ]
}
locals {
  db_secret_list = split(":",data.kubernetes_secret.cnpg.data["pgpass"])
  db_host = nonsensitive(local.db_secret_list[0])
  db_port = nonsensitive(local.db_secret_list[1])
  db_name = nonsensitive(local.db_secret_list[2])
  db_user = nonsensitive(local.db_secret_list[3])
  db_password = data.kubernetes_secret.cnpg.data["password"]
}