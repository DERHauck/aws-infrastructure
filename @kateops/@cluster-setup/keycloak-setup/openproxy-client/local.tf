locals {
  client_id = length(var.client_name) > 0 ?regexall("[a-z-]+", lower(var.client_name))[0] : var.sub_domain

}