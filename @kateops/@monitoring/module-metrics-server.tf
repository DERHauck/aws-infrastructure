module "metrics_server" {
  source = "./metrics-server-installation"

  namespace = kubernetes_namespace.this.metadata[0].name
}
