locals {
  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
  dns_suffix = data.aws_partition.current.dns_suffix
  irsa_oidc_provider_url = replace(var.irsa_oidc_provider_arn, "/^(.*provider/)/", "")
  irsa_name = "${var.cluster_name}-Karpenter-IRSA"
  iam_role_policy_prefix = "arn:${local.partition}:iam::aws:policy"
  iam_role_name          = "Karpenter-${var.cluster_name}"
  cni_policy = "${local.iam_role_policy_prefix}/AmazonEKS_CNI_Policy"
}