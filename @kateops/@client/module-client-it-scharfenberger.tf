module "it-scharfenberger" {
  source = "../../module/cluster/client"
  name   = "IT Scharfenberger"
  cluster_certificate_authority_data = local.cluster_certificate_authority_data
  cluster_endpoint = local.cluster_endpoint
  cluster_name = local.cluster_name
}

module "it-scharfenberger-projects" {
  source = "./module-it-scharfenberger-projects"
  group_id = module.it-scharfenberger.group_id
  depends_on = [
    module.it-scharfenberger
  ]
}