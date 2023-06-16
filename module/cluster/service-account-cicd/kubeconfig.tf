locals {
  kube_config = {
    apiVersion = "v1"
    kind = "Config"
    clusters = [
      {
        cluster = {
          certificate-authority-data = var.cluster_certificate_authority_data
          server = var.cluster_endpoint
        }
        name = var.cluster_name
      }
    ]
    contexts = [
      {
        context = {
          cluster: var.cluster_name
          namespace: var.namespace
          user: kubernetes_service_account.this.metadata[0].name

        }
        name = var.cluster_name
      }
    ]
    users: [
      {
        name: kubernetes_service_account.this.metadata[0].name
        user: {
          token = kubernetes_secret.this.data.token
        }
      }
    ]
    current-context = var.cluster_name
  }
}

resource "kubernetes_service_account" "this" {
  metadata {
    generate_name = "cicd-sa"
    namespace = var.namespace
  }

}


resource "kubernetes_secret" "this" {
  metadata {
    generate_name = "cicd-sa"
    namespace = var.namespace
    annotations = {
      "kubernetes.io/service-account.name": kubernetes_service_account.this.metadata[0].name
    }
  }
  type = "kubernetes.io/service-account-token"
  depends_on = [
    kubernetes_role_binding.this
  ]
}

resource "kubernetes_role" "this" {
  metadata {
    generate_name = "cicd-sa"
    namespace = var.namespace
  }
  rule {
    api_groups = [""]
    resources = ["*"]
    verbs = ["*"]
    resource_names = [var.namespace]
  }
}

#resource "kubernetes_cluster_role_binding" "this" {
#  metadata {
#    name = "cicd-crb-${kubernetes_role.this.metadata[0].name}"
#  }
#  role_ref {
#    api_group = "rbac.authorization.k8s.io"
#    kind      = "ClusterRole"
#    name      = "edit"
#  }
#
#  subject {
#    kind = "ServiceAccount"
#    name = kubernetes_service_account.this.metadata[0].name
#    namespace = kubernetes_service_account.this.metadata[0].namespace
#  }
#}


resource "kubernetes_role_binding" "this" {
  metadata {
    name = "cicd-sa"
    namespace = var.namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.this.metadata[0].name
  }
  subject {
    kind = "ServiceAccount"
    name = kubernetes_service_account.this.metadata[0].name
    namespace = kubernetes_service_account.this.metadata[0].namespace
  }
}