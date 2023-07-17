locals {
  sanitized_name = replace(lower(var.name), " ", "-")
  realm_id = "master"
}