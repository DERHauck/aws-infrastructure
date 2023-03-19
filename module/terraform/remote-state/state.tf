data "terraform_remote_state" "this" {
  backend = "s3"
  config = {
    region     = "eu-central-1"
    bucket     = "382168771427-terraform-state"
    key        = "aws/states/${var.state_name}/terraform.tfstate"
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
  }
}