resource "kubernetes_namespace" "this" {
  metadata {
    name = "monitoring"
    labels = {
      name = "monitoring"
    }
  }
}