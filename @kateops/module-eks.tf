//*
module "eks" {
  source = "../module/eks"
  cluster_name = "Production"
  subnet_id_map = {
    private = module.vpc.subnets.private.id,
    test = module.vpc.subnets.test.id
  }
  vpc_id = module.vpc.vpc_id
  hosted_zones = {
    (aws_route53_zone.kateops.zone_id) = aws_route53_zone.kateops.name
  }
}

//*/