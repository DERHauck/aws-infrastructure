module "ingress_controller" {
  source = "../../module/cluster/ingress-nginx"

  namespace = kubernetes_namespace.ingress.metadata[0].name
  public = true
  ip_family = "IPv4"
}