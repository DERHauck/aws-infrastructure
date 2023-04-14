resource "vault_generic_secret" "rdbs" {
  for_each = var.rdbs
  path      = "kateops/rdbs/${each.key}"
  data_json = jsonencode(each.value)
}

resource "vault_generic_secret" "keycloak" {
  path      = "kateops/keycloak/rdbs"
  data_json = jsonencode(var.keycloak_rdbs)
}

resource "vault_identity_oidc_key" "keycloak_provider_key" {
  name      = "keycloak"
  algorithm = "RS256"
}

resource "vault_jwt_auth_backend" "keycloak" {
  path               = "oidc"
  type               = "oidc"
  default_role       = "reader"
  oidc_discovery_url = format("https://sso.kateops.com/realms/%s", var.keycloak_realm)
  oidc_client_id     = var.keycloak_client_id
  oidc_client_secret = var.keycloak_client_secret

  tune {
    audit_non_hmac_request_keys  = []
    audit_non_hmac_response_keys = []
    default_lease_ttl            = "1h"
    listing_visibility           = "unauth"
    max_lease_ttl                = "1h"
    passthrough_request_headers  = []
    token_type                   = "default-service"
  }
}


resource "vault_jwt_auth_backend_role" "reader" {
  backend       = vault_jwt_auth_backend.keycloak.path
  role_name     = "reader"
  role_type     = "oidc"
  token_ttl     = 3600
  token_max_ttl = 3600

  token_policies = [
    vault_policy.reader_policy.name
  ]
  bound_audiences = [var.keycloak_client_id]
  user_claim      = "sub"
  claim_mappings  = {
    preferred_username = "username"
    email              = "email"
  }

  allowed_redirect_uris = [
    "https://vault.kateops.com/ui/vault/auth/oidc/oidc/callback",
    "https://vault.kateops.com/oidc/callback",
    "http://localhost:8250/oidc/callback"
  ]
  groups_claim = format("/resource_access/%s/roles",
    var.keycloak_client_id)
}

resource "vault_jwt_auth_backend_role" "admin" {
  backend       = vault_jwt_auth_backend.keycloak.path
  role_name     = "admin"
  role_type     = "oidc"
  token_ttl     = 3600
  token_max_ttl = 3600

  token_policies = [
    vault_policy.admin_policy.name
  ]
  bound_audiences = [var.keycloak_client_id]
  user_claim      = "sub"
  claim_mappings  = {
    preferred_username = "username"
    email              = "email"
  }

  allowed_redirect_uris = [
    "https://vault.kateops.com/ui/vault/auth/oidc/oidc/callback",
    "https://vault.kateops.com/oidc/callback",
    "http://localhost:8250/oidc/callback"
  ]
  groups_claim = format("/resource_access/%s/roles",
    var.keycloak_client_id)
}

resource "vault_jwt_auth_backend_role" "management" {
  backend       = vault_jwt_auth_backend.keycloak.path
  role_name     = "management"
  role_type     = "oidc"
  token_ttl     = 3600
  token_max_ttl = 3600

  token_policies = [
    vault_policy.manager_policy.name
  ]
  bound_audiences = [var.keycloak_client_id]
  user_claim      = "sub"
  claim_mappings  = {
    preferred_username = "username"
    email              = "email"
  }

  allowed_redirect_uris = [
    "https://vault.kateops.com/ui/vault/auth/oidc/oidc/callback",
    "https://vault.kateops.com/oidc/callback",
    "http://localhost:8250/oidc/callback"
  ]
  groups_claim = format("/resource_access/%s/roles",
    var.keycloak_client_id)
}


resource "vault_policy" "reader_policy" {
  name   = "reader"
  policy = data.vault_policy_document.reader_policy.hcl
}

resource "vault_policy" "manager_policy" {
  name   = "management"
  policy = data.vault_policy_document.manager_policy.hcl
}

resource "vault_policy" "admin_policy" {
  name   = "admin"
  policy = data.vault_policy_document.admin.hcl
}

resource "vault_policy" "service_policy" {
  name   = "service"
  policy = data.vault_policy_document.service_policy.hcl
}

resource "vault_policy" "terraform_service" {
  name   = "scaleway_api"
  policy = data.vault_policy_document.terraform_service.hcl
}


resource "vault_identity_oidc_role" "reader_role" {
  name = "reader"
  key  = vault_identity_oidc_key.keycloak_provider_key.name
}

resource "vault_identity_oidc_role" "management_role" {
  name = "management"
  key  = vault_identity_oidc_key.keycloak_provider_key.name
}

resource "vault_identity_oidc_role" "admin_role" {
  name = "admin"
  key  = vault_identity_oidc_key.keycloak_provider_key.name
}


resource "vault_identity_group" "reader_group" {
  name = vault_identity_oidc_role.reader_role.name
  type = "external"
}

resource "vault_identity_group" "management_group" {
  name = vault_identity_oidc_role.management_role.name
  type = "external"
}

resource "vault_identity_group" "admin_group" {
  name = vault_identity_oidc_role.admin_role.name
  type = "external"
}


resource "vault_identity_group_alias" "reader_group_alias" {
  name           = "reader"
  mount_accessor = vault_jwt_auth_backend.keycloak.accessor
  canonical_id   = vault_identity_group.reader_group.id
}

resource "vault_identity_group_alias" "management_group_alias" {
  name           = "management"
  mount_accessor = vault_jwt_auth_backend.keycloak.accessor
  canonical_id   = vault_identity_group.management_group.id
}

resource "vault_identity_group_alias" "admin_group_alias" {
  name           = "admin"
  mount_accessor = vault_jwt_auth_backend.keycloak.accessor
  canonical_id   = vault_identity_group.admin_group.id
}