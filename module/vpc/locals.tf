locals {
  availability_zones = ["eu-central-1a", "eu-central-1b"]
  private_cluster_tags = {
    "kubernetes.io/role/internal-elb" = 1
    "karpenter.sh/discovery" = true
  }
  public_cluster_tags = {
    "kubernetes.io/role/elb" = 1
  }
}