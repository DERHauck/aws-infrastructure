resource "kubernetes_namespace" "this" {
  metadata {
    name = "administration"
    labels = {
      name = "administration"
      confidentiality = "admin"
    }
  }
}