resource "keycloak_openid_client" "this" {
  realm_id = var.realm
  client_id = local.client_id
  name = var.client_name
  access_type = "CONFIDENTIAL"
  standard_flow_enabled = true
  valid_redirect_uris = [
    "https://${var.sub_domain}.${var.host_domain}/oauth2/callback"
  ]
  login_theme = "keycloak"
}


