module "dollar" {
  source = "../../module/cluster/client"
  name   = "Dollar"
  cluster_certificate_authority_data = local.cluster_certificate_authority_data
  cluster_endpoint = local.cluster_endpoint
  cluster_name = local.cluster_name
}

module "dollar-projects" {
  source = "./module-dollar-projects"
  group_id = module.dollar.group_id
  depends_on = [
    module.dollar
  ]
}
