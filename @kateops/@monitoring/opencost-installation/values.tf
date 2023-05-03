locals {
  vars = {
    host_domain: var.host_domain
    fqdn_prometheus_service: var.fqdn_prometheus_service
    storage_class: var.storage_class
    grafana_service: var.grafana_service
  }
  secrets = {
  }
  secret_templates = [for v in fileset("${path.module}/values","*.yml"): templatefile("${path.module}/values/${v}", local.secrets) ]
  raw_templates = [ for v in fileset("${path.module}/values","*.yaml"): templatefile("${path.module}/values/${v}", local.vars) ]
  templates = concat(local.raw_templates, local.secret_templates)
}