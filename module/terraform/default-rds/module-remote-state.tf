module "default" {
  source = "../remote-state"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  state_name = var.state_name
}