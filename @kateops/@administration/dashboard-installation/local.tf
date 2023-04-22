locals {
  create_service_account = var.is_admin ? false : true
}