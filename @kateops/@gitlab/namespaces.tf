
resource "kubernetes_namespace" "gitlab" {
  metadata {
    name   = "gitlab"
    labels = {
      name = "gitlab"
    }
  }
}

