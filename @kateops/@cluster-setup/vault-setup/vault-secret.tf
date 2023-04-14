resource "vault_mount" "kateops" {
  path        = "kateops"
  type        = "kv"
  description = "Kateops default K/V vault, available for services"
  options = {
    version = 2
  }

  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}

resource "vault_mount" "admin" {
  path        = "admin"
  type        = "kv"
  description = "Kateops admin K/V vault, available for only for administrators"
  options = {
    version = 2
  }
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}