provider "aws" {
  region = local.default_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  default_tags {
    tags = {
      "kateops:context" = "Infrastructure"
      "kateops:iam" = "terraform"
      "kateops:iac" = "Terraform"
      "kateops:account" = "Kateops"
      "kateops:state" = "kateops/cluster"
    }
  }
}