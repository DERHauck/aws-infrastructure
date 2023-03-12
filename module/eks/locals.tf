locals {
  cluster_name = lower(replace(var.cluster_name, " ", "-"))

  # Used to determine correct partition (i.e. - `aws`, `aws-gov`, `aws-cn`, etc.)
  partition = data.aws_partition.current.partition

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
  eks_oidc_issuer               = trimprefix(module.eks.cluster_oidc_issuer_url, "https://")
  system_namespace = "kube-system"
  irsa_suffix = "irsa"

  tags = merge(var.tags, {
    "kateops:environment" = local.cluster_name
  })
}

data "aws_partition" "current" {}
data "aws_availability_zones" "available" {}