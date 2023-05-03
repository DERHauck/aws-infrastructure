provider "helm" {
  kubernetes {
    host                   = local.cluster_endpoint
    cluster_ca_certificate = base64decode(local.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      # This requires the awscli to be installed locally where Terraform is executed
      args = ["eks", "get-token", "--cluster-name", local.cluster_name, "--region", "eu-central-1"]
      env = {
        AWS_ACCESS_KEY_ID = var.aws_access_key
        AWS_SECRET_ACCESS_KEY = var.aws_secret_key
      }
    }
  }
}
