module "node_exporter" {
    source = "./node-exporter-installation"
    namespace = kubernetes_namespace.this.metadata[0].name
}