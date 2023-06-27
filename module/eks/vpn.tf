resource "helm_release" "tailscale" {
  repository = "https://charts.visonneau.fr"
  chart = "tailscale-relay"
  namespace = local.system_namespace
  name  = "vpn"
  set {
    name  = "config.authKey"
    value = "tskey-auth-kuxttR5CNTRL-wBurnzB36KH3wQnNruBkKHMaBRNdEjKG"
  }
  set {
    name  = "config.variables.TAILSCALE_ADVERTISE_ROUTES"
    value = local.vpc_cidr
  }
}