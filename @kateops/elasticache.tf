locals {
  elasticache_port = 6379
}


resource "aws_security_group" "elasticache" {
  vpc_id = module.vpc.vpc_id
  name = "elasticache-default"
  ingress {
    from_port = local.elasticache_port
    protocol  = "tcp"
    to_port   = local.elasticache_port
    cidr_blocks = [local.vpc_cidr]
  }
  egress {
    from_port = 0
    protocol  = "tcp"
    to_port   = 65535
    cidr_blocks = [local.vpc_cidr]
  }
}



resource "aws_elasticache_cluster" "elasticache" {
  cluster_id = "${local.environment_name}-default"
  engine = "redis"
  node_type = "cache.t3.micro"
  engine_version = "4.0.10"
  num_cache_nodes = 1
  parameter_group_name = "default.redis4.0"
  port = local.elasticache_port
  subnet_group_name = module.vpc.db_subnet_groups.elasticache.name
  security_group_ids = [aws_security_group.elasticache.id]

}
