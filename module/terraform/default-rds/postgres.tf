resource "postgresql_database" "this" {
  name = var.database
  owner = postgresql_role.this.name
}

resource "postgresql_schema" "this" {
  name = var.database
  owner = postgresql_role.this.name
  database = postgresql_database.this.name
}


resource "postgresql_role" "this" {
  name = var.username
  login = true
  password = random_password.this.result
}

resource "random_password" "this" {
  length = 15
  min_lower = 1
  min_numeric = var.password_special ? 1 : 0
  min_special = 1
  min_upper = 1
  special = var.password_special
  numeric = true
  lower = true
  upper = true
}