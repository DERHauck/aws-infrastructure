module "grafana_agent_operator" {
  source = "./grafana-agent-operator-installation"

  namespace = kubernetes_namespace.this.metadata[0].name
  mimir_service = module.mimir.mimir_service
}
