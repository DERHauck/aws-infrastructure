data "vault_policy_document" "admin" {
  rule {
    path         = "*"
    capabilities = ["create", "update", "delete", "sudo", "read", "list"]
  }
}

data "vault_policy_document" "terraform_service" {
  rule {
    path         = "/admin/data/*"
    capabilities = ["read"]
  }
  rule {
    path         = "/admin/service/*"
    capabilities = ["read"]
  }
}

data "vault_policy_document" "manager_policy" {
  rule {
    path         = "/kateops/*"
    capabilities = ["create", "update", "read", "delete", "list"]
  }
}

data "vault_policy_document" "reader_policy" {
  rule {
    path         = "/kateops/*"
    capabilities = ["read", "list"]
  }
}

data "vault_policy_document" "service_policy" {
  rule {
    path         = "auth/token/create"
    capabilities = ["update", "create"]
  }
}