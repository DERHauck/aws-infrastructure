locals {
  vars = {
    host_domain: var.host_domain
    service_account_name: var.service_account_name
    create_service_account: local.create_service_account
  }
  secrets = {

  }
  secret_templates = [ for v in fileset("${path.module}/values","*.yml"): templatefile("${path.module}/values/${v}", local.secrets) ]
  raw_templates = [ for v in fileset("${path.module}/values","*.yaml"): templatefile("${path.module}/values/${v}", local.vars) ]
  templates = concat(local.raw_templates, local.secret_templates)
}