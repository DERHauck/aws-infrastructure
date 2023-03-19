
module "vpc" {
  source = "../module/vpc"
  name = local.environment_name
  cidr_block = local.vpc_cidr
}
