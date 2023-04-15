module "oss" {
  source = "./oss"
}

module "oss_label" {
  source = "./default-labels"
  group_id = module.oss.group_id
}


#######################################
# Projects
#######################################



module "kubernetes_tutorial" {
  source = "./project-public"
  name = "K8 Tutorial"
  description = "Kubernetes Developer Tutorial"
  group_id = module.oss.group_id
}