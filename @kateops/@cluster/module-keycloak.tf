module "keycloak" {
  source = "./keycloak-installation"
  namespace = kubernetes_namespace.security.metadata[0].name
  rdbs = module.keycloak_db
}

module "keycloak_db" {
  source = "../../module/terraform/default-rds"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  database = "keycloak_db"
  state_name = "kateops"
  username = "kateops_user"
}