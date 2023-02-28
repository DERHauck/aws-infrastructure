//*
module "eks" {
  source = "../module/eks"
  cluster_name = "Production"
  subnet_id_list = [
    module.vpc.subnets.private.id,
    module.vpc.subnets.test.id
  ]
  vpc_id = module.vpc.vpc_id
}

//*/