module "kube_state_metrics" {
    source = "./kube-state-metrics-installation"
    namespace = kubernetes_namespace.this.metadata[0].name
}