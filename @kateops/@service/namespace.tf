resource "kubernetes_namespace" "this" {
  metadata {
    name = "service"
    labels = {
      name = "services"
    }
  }
}