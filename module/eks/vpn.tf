resource "helm_release" "tailscale" {
  repository = "https://charts.visonneau.fr"
  chart = "tailscale-relay"
  namespace = local.system_namespace
  name  = "vpn"
  set {
    name  = "config.authKey"
    value = "tskey-auth-k3qnAa4CNTRL-Y2L19SQi9tepe6fsiowUseHx4ZCBa79Yi"
  }
  set {
    name  = "config.variables.TAILSCALE_ADVERTISE_ROUTES"
    value = local.vpc_cidr
  }
}