module "schenk" {
  source = "../../module/cluster/client"
  name   = "Schenk"
  cluster_certificate_authority_data = local.cluster_certificate_authority_data
  cluster_endpoint = local.cluster_endpoint
  cluster_name = local.cluster_name
}

module "schenk-projects" {
  source = "./module-schenk-projects"
  group_id = module.schenk.group_id
  depends_on = [
    module.schenk
  ]
}