module "rs_cluster" {
  source = "../../module/terraform/remote-state"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  state_name = "kateops/cluster"
}

module "rs_kateops" {
  source = "../../module/terraform/remote-state"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  state_name = "kateops"
}