locals {
  client_id = regexall("[a-z-]+", lower(var.sub_domain))[0]
}