module "kateops-org" {
  source = "../../module/cluster/client"
  name   = "Kateops Org"
  cluster_certificate_authority_data = local.cluster_certificate_authority_data
  cluster_endpoint = local.cluster_endpoint
  cluster_name = local.cluster_name
}

module "kateops-org-projects" {
  source = "./module-kateops-org-projects"
  group_id = module.kateops-org.group_id
  depends_on = [
    module.kateops-org
  ]
}