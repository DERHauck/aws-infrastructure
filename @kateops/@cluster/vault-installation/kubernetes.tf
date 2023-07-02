resource "kubernetes_cluster_role_binding" "injector" {
  metadata {
    name = "vault-injector-cr-delegator"
  }
  role_ref {
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
    api_group = "rbac.authorization.k8s.io"
  }
  subject {
    kind = "ServiceAccount"
    name = "vault-agent-injector"
    namespace = "security"
  }

}