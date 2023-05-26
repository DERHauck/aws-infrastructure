module "node_exporter" {
    source "./node_exporter-installation"
    namespace = kubernetes_namespace.this.metadata[0].name
}