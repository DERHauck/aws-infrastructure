resource "kubectl_manifest" "keda_dashboard" {
  for_each  = local.scaling_dashboard
  yaml_body = each.value
}
resource "kubectl_manifest" "keda_proxy" {
  for_each  = local.scaling_proxy
  yaml_body = each.value
}

locals {
  deployments = {
    proxy = {
      name      = "dashboard-openproxy-oauth2-proxy"
      namespace = var.namespace
    }
    dashboard = {
      name      = "kube-dashboard-kubernetes-dashboard"
      namespace = var.namespace
    }
  }
  scaling_dashboard = {
    for v in fileset("${path.module}/keda", "*") : v =>
    templatefile("${path.module}/keda/${v}", local.deployments.dashboard)
  }
  scaling_proxy     = {
    for v in fileset("${path.module}/keda", "*") : v =>
    templatefile("${path.module}/keda/${v}", local.deployments.proxy)
  }
}