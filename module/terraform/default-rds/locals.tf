locals {
  host = module.default.outputs.postgres.address
  username = module.default.outputs.postgres.username
  password = module.default.outputs.postgres.password
  port = module.default.outputs.postgres.port
}