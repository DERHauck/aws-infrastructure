module "promtail" {
  source = "./promtail-installation"

  namespace = kubernetes_namespace.this.metadata[0].name
  tenant_id = "kateops"
}