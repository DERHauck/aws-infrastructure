module "buildkit" {
  source = "./buildkit-installation"
  namespace = kubernetes_namespace.gitlab.metadata[0].name
}