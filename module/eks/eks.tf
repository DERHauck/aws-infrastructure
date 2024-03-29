module "eks" {
  # https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
  source  = "terraform-aws-modules/eks/aws"
  version = "19.10.0"

  cluster_name    = local.cluster_name
  cluster_version = "1.27"

  vpc_id                      = var.vpc_id
  subnet_ids                  = [for key, id in var.subnet_id_map : id]
  control_plane_subnet_ids    = [for key, id in var.subnet_id_map : id]
  create_cloudwatch_log_group = false
  # Required for Karpenter role below
  enable_irsa                 = true
  cluster_enabled_log_types   = []
  /*
    cluster_security_group_additional_rules = {

    }
  //*/

  node_security_group_additional_rules = {
    egress_https = {
      description = "Cluster wide Access"
      protocol    = "tcp"
      from_port   = 0
      to_port     = 65535
      type        = "egress"
      self        = true
    }
    ingress_https = {
      description = "Cluster wide Access"
      protocol    = "tcp"
      from_port   = 0
      to_port     = 65535
      type        = "ingress"
      self        = true
    }
  }

  /*
     initial = {
        instance_types = ["t3a.micro"]
        # Not required nor used - avoid tagging two security groups with same tag as well
        create_security_group = false

        # Ensure enough capacity to run 2 Karpenter pods
        min_size     = 1
        max_size     = 3
        desired_size = 1
      }

    //*/
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  manage_aws_auth_configmap       = true
  create_aws_auth_configmap       = false
  aws_auth_roles                  = [
    {
      rolearn = [
        for parts in [for arn in data.aws_iam_roles.admin.arns : split("/", arn)] :
        format("%s/%s", parts[0], element(parts, length(parts) - 1))
      ][
      0
      ],
      username = "admin"
      groups   = ["system:masters"]
    }
  ]
  iam_role_additional_policies = {

  }

  eks_managed_node_groups = {
    karpenter = {
      instance_types               = ["t3a.micro"]
      # Not required nor used - avoid tagging two security groups with same tag as well
      create_security_group        = false
      iam_role_additional_policies = {
        ebs = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
      # Ensure enough capacity to run 2 Karpenter pods
      min_size     = 1
      max_size     = 3
      desired_size = 1
      taints       = {
        karpenter = {
          key    = "karpenter.sh/manager"
          value  = "true"
          effect = "NO_EXECUTE"
        }
      }
    }

  }
  node_security_group_tags = {
    "karpenter.sh/discovery" = local.cluster_name
  }
  tags = local.tags
}

data "aws_iam_roles" "admin" {
  name_regex = "AWSReservedSSO_AdministratorAccess.*"
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name         = module.eks.cluster_name
  addon_name           = "vpc-cni"
  resolve_conflicts    = "OVERWRITE"
  addon_version        = "v1.15.1-eksbuild.1"
  configuration_values = jsonencode({
    env = {
      # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
      ENABLE_PREFIX_DELEGATION = "true"
      ENABLE_POD_ENI           = "true"
      WARM_PREFIX_TARGET       = "0"
      WARM_IP_TARGET           = "1"
      MINIMUM_IP_TARGET        = "1"
    }
  })
  tags = local.tags
}


resource "aws_eks_addon" "coredns" {
  cluster_name      = module.eks.cluster_name
  addon_name        = "coredns"
  addon_version     = "v1.10.1-eksbuild.4"
  resolve_conflicts = "OVERWRITE"
  depends_on        = [
    helm_release.karpenter,
    aws_eks_addon.vpc_cni,
  ]

  tags = local.tags
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name      = module.eks.cluster_name
  addon_name        = "kube-proxy"
  resolve_conflicts = "OVERWRITE"
  depends_on        = [
    helm_release.karpenter,
    aws_eks_addon.coredns,
  ]
  tags = local.tags
}


resource "aws_eks_addon" "ebs_cni" {
  cluster_name         = module.eks.cluster_name
  addon_name           = "aws-ebs-csi-driver"
  resolve_conflicts    = "OVERWRITE"
  configuration_values = jsonencode({
    node = {
      tolerations = []
    }
  })
  depends_on = [
    helm_release.karpenter,
    aws_eks_addon.coredns,
  ]
  tags = local.tags
}