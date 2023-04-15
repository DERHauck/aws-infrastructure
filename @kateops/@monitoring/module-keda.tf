module "keda" {
  source = "./keda-installation"
  namespace = kubernetes_namespace.this.metadata[0].name
}