locals {
  cluster_name = module.rs_kateops.outputs.clusters.production.cluster_name
  cluster_endpoint = module.rs_kateops.outputs.clusters.production.cluster_endpoint
  cluster_certificate_authority_data = module.rs_kateops.outputs.clusters.production.cluster_certificate_authority_data
  node_security_group_id = module.rs_kateops.outputs.clusters.production.node_security_group_id
  oidc_issuer = module.rs_kateops.outputs.clusters.production.oidc_issuer
  oidc_issuer_arn = module.rs_kateops.outputs.clusters.production.oidc_issuer_arn
  default_region = "eu-central-1"
  redis_endpoint = "redis-master.security.svc.cluster.local:6379"
}