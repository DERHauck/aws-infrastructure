locals {
  sanitized_name = replace(lower(var.name), " ", "-")
}