/*
module "karpenter" {
  source  = "./karpenter"

  cluster_name = module.eks.cluster_name

  irsa_oidc_provider_arn          = module.eks.oidc_provider_arn
  irsa_namespace_service_accounts = ["karpenter:karpenter"]
}
//*/
module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "18.31.0"

  cluster_name = module.eks.cluster_name

  irsa_oidc_provider_arn          = module.eks.oidc_provider_arn
  irsa_namespace_service_accounts = ["karpenter:karpenter"]

  # Since Karpenter is running on an EKS Managed Node group,
  # we can re-use the role that was created for the node group
  create_iam_role = false
  iam_role_arn    = module.eks.eks_managed_node_groups["karpenter"].iam_role_arn
  tags = local.tags
}
//*/

resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true

  name                = "karpenter"
  repository          = "oci://public.ecr.aws/karpenter"
  chart               = "karpenter"
  version             = "v0.26.0"

  values = [
    templatefile("${path.module}/karpenter/values.yaml", {

    })
  ]

  set {
    name  = "settings.aws.clusterName"
    value = module.eks.cluster_name
  }

  set {
    name  = "settings.aws.clusterEndpoint"
    value = module.eks.cluster_endpoint
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.karpenter.irsa_arn
  }

  set {
    name  = "settings.aws.defaultInstanceProfile"
    value = module.karpenter.instance_profile_name
  }
}

resource "kubectl_manifest" "this" {
  for_each = { for v in fileset("${path.module}/manifests", "*.karpenter.yaml"): "${path.module}/manifests/${v}" => "${path.module}/manifests/${v}" }
  yaml_body = templatefile(each.value, {
    cluster_name = module.eks.cluster_name
    availability_zones = [distinct([ for  num, subnet in data.aws_subnet.private : subnet.availability_zone ])[0]]
  })

  depends_on = [
    helm_release.karpenter
  ]
}
