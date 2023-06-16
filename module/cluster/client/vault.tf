resource "vault_mount" "this" {
  path        = local.sanitized_name
  type        = "kv"
  description = "${var.name} K/V vault"
  options = {
    version = 2
  }
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}