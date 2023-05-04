locals {
  namespace = var.namespace
  app = "buildkitd"
  labels = {
    app = local.app
  }
}
