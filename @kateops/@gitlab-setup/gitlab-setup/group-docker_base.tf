module "docker-base" {
  source = "./docker-base"
}

module "docker_base_label" {
  source = "./default-labels"
  group_id = module.docker-base.group_id
}

#######################################
# BASE IMAGES
#######################################

module "base-terraform" {
  source = "./project-public"
  name = "Terraform"
  description = "Default terraform image"
  group_id = module.docker-base.group_id
}

module "base-php" {
  source = "./project-public"
  name = "PHP"
  description = "Default php image"
  group_id = module.docker-base.group_id
}

module "base-linter" {
  source = "./project-public"
  name = "Linter"
  description = "Default docker image linter"
  group_id = module.docker-base.group_id
}

module "base-ansible" {
  source = "./project-public"
  name = "Ansible"
  description = "Default ansible image"
  group_id = module.docker-base.group_id
}

module "base-node" {
  source = "./project-public"
  name = "Node"
  description = "Default node image"
  group_id = module.docker-base.group_id
}

module "base-public" {
  source = "./project-public"
  name = "public"
  description = "Public Base Images"
  group_id = module.docker-base.group_id
}