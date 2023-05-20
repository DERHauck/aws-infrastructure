resource "kubernetes_namespace" "deployment" {
  metadata {
    name = "deployment"
  }
}

module "ns-deployment_service_account" {
  source = "./../../module/cluster/service-account-cicd"
  cluster_certificate_authority_data = local.cluster_certificate_authority_data
  cluster_endpoint = local.cluster_endpoint
  cluster_name = local.cluster_name
  namespace = kubernetes_namespace.deployment.metadata[0].name
}
