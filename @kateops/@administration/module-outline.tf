module "outline" {
  source = "./outline-installation"
  namespace = kubernetes_namespace.this.metadata[0].name
  host_domain = "outline.kateops.com"
  rdbs = module.outline_db
  redis_endpoint = local.redis_endpoint
  redis_password = data.vault_generic_secret.redis.data["password"]
}


module "outline_db" {
  source = "../../module/terraform/default-rds"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  database = "outline_db"
  state_name = "kateops"
  username = "outline_user"
  password_special = false
}