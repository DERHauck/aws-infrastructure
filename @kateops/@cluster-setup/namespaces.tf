
resource "kubernetes_namespace" "argo" {
  metadata {
    name   = "argo"
    labels = {
      name = "argo"
    }
  }
}

