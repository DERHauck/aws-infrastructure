module "vault_setup" {
  source = "./vault-setup"
  vault_root_token        = var.vault_root_token
}


module "vault_secrets" {
  source = "./vault-secrets"

  k8_certificate          = local.cluster_certificate_authority_data
  k8_endpoint             = local.cluster_endpoint
  k8_region               = local.default_region
  k8_token                = ""
  k8_zone                 = ""
  keycloak_admin_password = module.rs_cluster.outputs.keycloak.keycloak_admin_password
  keycloak_admin_username = module.rs_cluster.outputs.keycloak.keycloak_admin_username
  keycloak_client_id      = module.keycloak_setup.vault_client_id
  keycloak_client_secret  = module.keycloak_setup.vault_client_secret
  keycloak_realm          = "master"
  access_key              = var.aws_access_key
  secret_key              = var.aws_secret_key
  keycloak_rdbs           = {}
  rdbs                    = {}

  admin_mount_path = module.vault_setup.admin_mount_path
}