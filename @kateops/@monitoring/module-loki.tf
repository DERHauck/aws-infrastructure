module "loki" {
  source = "./loki-installation"

  namespace = kubernetes_namespace.this.metadata[0].name
  host_domain = "loki.kateops.com"
}
