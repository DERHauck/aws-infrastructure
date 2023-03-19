resource "kubernetes_namespace" "ingress" {
  metadata {
    name   = "ingress"
    labels = {
      name = "ingress"
    }
  }
}

resource "kubernetes_namespace" "security" {
  metadata {
    name   = "security"
    labels = {
      name = "security"
    }
  }
}

