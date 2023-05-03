module "portainer" {
  source = "./portainer-installation"
  namespace = kubernetes_namespace.this.metadata[0].name
  host_domain = "portainer.kateops.com"
}
