locals {
  postgres_port = 5432
}

resource "random_password" "postgres" {
  length = 12
  special = true
  upper = true
  numeric = true
  min_lower = 2
  min_numeric = 2
  min_special = 2
  min_upper = 2
}


resource "aws_security_group" "postgres" {
  vpc_id = module.vpc.vpc_id
  name = "postgres-default"
  ingress {
    from_port = local.postgres_port
    protocol  = "tcp"
    to_port   = local.postgres_port
    cidr_blocks = [local.vpc_cidr]
  }
  egress {
    from_port = 0
    protocol  = "tcp"
    to_port   = 65535
    cidr_blocks = [local.vpc_cidr]
  }
}

resource "aws_db_instance" "postgres" {
  engine = "postgres"
  engine_version = "14.7"
  db_name = "postgres_default"
  identifier = "${local.environment_name}-default"
  username = "master"
  password = random_password.postgres.result
  instance_class = "db.t3.micro"
  storage_type = "gp3"
  allocated_storage = 20
  multi_az = false
  db_subnet_group_name = module.vpc.db_subnet_groups.rds.name
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.postgres.id]
  port = local.postgres_port
  iam_database_authentication_enabled = false
  parameter_group_name = "defaultpsql14"
  backup_retention_period = 14
  backup_window = "03:00-04:00"
  maintenance_window = "Sat:00:00-Sat:02:00"
  final_snapshot_identifier = "default-postgresql-final-snapshot"
  delete_automated_backups = true
  storage_encrypted = true
  auto_minor_version_upgrade = true
  apply_immediately = true
}

