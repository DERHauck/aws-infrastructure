resource "vault_kv_secret_v2" "keycloak" {
  mount     = var.admin_mount_path
  name      = "keycloak/admin"
  data_json = jsonencode({
    password : var.keycloak_admin_password
    username : var.keycloak_admin_username
  })
}

resource "vault_kv_secret_v2" "k8_kateops" {
  mount     = var.admin_mount_path
  name      = "k8/kateops"
  data_json = jsonencode({
    token : var.k8_token
    endpoint : var.k8_endpoint
    certificate : var.k8_certificate
    region: var.k8_region
    zone: var.k8_zone
  })
}


resource "vault_kv_secret_v2" "scaleway" {
  mount     = var.admin_mount_path
  name      = "scaleway/default"
  data_json = jsonencode({
    access_key : var.access_key
    secret_key : var.secret_key
  })
}

resource "vault_token" "terraform_service_token" {
  policies = [
    vault_policy.terraform_service.name,
    vault_policy.manager_policy.name,
  ]
  display_name = "vault-service-token"
  ttl              = "700h"
  renewable        = true
  no_parent        = true
  explicit_max_ttl = "700h"

  metadata = {
    "purpose" = "service-account"
  }
}

resource "vault_kv_secret_v2" "terraform_service_token" {
  mount     = var.admin_mount_path
  name      = "service"
  data_json = jsonencode({
    terraform : vault_token.terraform_service_token.client_token
  })
}