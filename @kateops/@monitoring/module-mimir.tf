module "mimir" {
  source = "./mimir-installation"

  namespace = kubernetes_namespace.this.metadata[0].name
  host_domain = "mimir.kateops.com"
}
