resource "aws_db_subnet_group" "this" {
  name = "rds-${var.name}"
  subnet_ids = [
    aws_subnet.private.id,
    aws_subnet.test.id,
  ]
}

resource "aws_elasticache_subnet_group" "this" {
  name       = "elasticache-${var.name}"
  subnet_ids = [
    aws_subnet.private.id,
    aws_subnet.test.id,
  ]
}