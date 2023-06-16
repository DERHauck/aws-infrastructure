module "kateops-org" {
  source = "../../module/cluster/client"
  name   = "Kateops Org"
  cluster_certificate_authority_data = local.cluster_certificate_authority_data
  cluster_endpoint = local.cluster_endpoint
  cluster_name = local.cluster_name
}