module "redis" {
  source = "./redis-installation"
  namespace = kubernetes_namespace.security.metadata[0].name

  helm_name            = "redis"
  monitoring_namespace = "monitoring"
}