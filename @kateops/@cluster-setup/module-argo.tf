module "argo-installation" {
  source = "./argo-installation"
  namespace = kubernetes_namespace.argo.metadata[0].name
  argo_host_name = "argo.kateops.com"
  webhook_host_name = "hooks.argo.kateops.com"
  redis = module.rs_cluster.outputs.redis
}