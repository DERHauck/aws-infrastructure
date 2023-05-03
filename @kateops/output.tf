output "postgres" {
  value = {
    endpoint = aws_db_instance.postgres.endpoint
    address  = aws_db_instance.postgres.address
    username = aws_db_instance.postgres.username
    password = aws_db_instance.postgres.password
    port     = aws_db_instance.postgres.port
    database = aws_db_instance.postgres.db_name
  }
  sensitive = true
}

output "elasticache" {
  value = aws_elasticache_cluster.elasticache.cache_nodes[0]
  sensitive = true
}

output "clusters" {
  value = {
    (local.environment_name) = module.eks
  }
}