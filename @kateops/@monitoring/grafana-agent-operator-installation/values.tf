locals {
  vars = {
    service_account_name = local.service_account_name
  }

  crds_vars = {
    namespace = var.namespace
    service_account_name = local.service_account_name
    mimir_service = var.mimir_service
  }

  templates = [ for v in fileset("${path.module}/values","*.yaml"): templatefile("${path.module}/values/${v}", local.vars) ]
  crds = { for v in fileset("${path.module}/crds","*.yaml"): v => templatefile("${path.module}/crds/${v}", local.crds_vars) }
}




locals {
  service_account_name = "grafana-agent-operator"
}