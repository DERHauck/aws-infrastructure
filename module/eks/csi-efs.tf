locals {
  efs_service_account_name = "efs-sa"
}

resource "helm_release" "csi_efs" {
  repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
  chart  = "aws-efs-csi-driver"
  name = "efs"
  namespace = "kube-system"
  version = "2.4.0"
  values = [
    templatefile("${path.module}/charts/efs-controller.yaml", {
      iam_role_arn = aws_iam_role.efs.arn
      efs_filesystem_id = aws_efs_file_system.this.id
      efs_controller_service_account = local.efs_service_account_name
    })
  ]
  depends_on = [
    aws_eks_addon.coredns
  ]
}

resource "aws_efs_file_system" "this" {
  encrypted = true
  tags = {
    Name = "eks-${local.cluster_name}"
  }
}

resource "aws_security_group" "efs" {
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "efs" {
  from_port         = 2049
  protocol          = "tcp"
  to_port           = 2049
  type              = "ingress"
  cidr_blocks      = [local.vpc_cidr]
  ipv6_cidr_blocks = ["::/0"]
  security_group_id = aws_security_group.efs.id
}

resource "aws_efs_mount_target" "this" {
  for_each = var.subnet_id_map
  file_system_id = aws_efs_file_system.this.id
  subnet_id      = each.value
  security_groups = [
    aws_security_group.efs.id
  ]
}

resource "aws_iam_role" "efs" {
  name = "EFS_${local.cluster_name}"

  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = [
          "sts:AssumeRoleWithWebIdentity"
        ]
        Effect    = "Allow"
        Principal = {
          Federated = [
            "arn:aws:iam::${data.aws_caller_identity.this.account_id}:oidc-provider/${local.eks_oidc_issuer}"
          ]
        }
        Condition = {
          StringEquals = {
            ("${local.eks_oidc_issuer}:sub") = "system:serviceaccount:${local.system_namespace}:${local.efs_service_account_name}"
          }
        }
      }
    ]
    Version = "2012-10-17"
  })
  tags = var.tags
}


resource "aws_iam_policy" "efs_csi" {

  name   = "AmazonEKS_EFS_CSI_${local.cluster_name}"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action = [
          "elasticfilesystem:DescribeAccessPoints",
          "elasticfilesystem:DescribeFileSystems",
          "elasticfilesystem:DescribeMountTargets",
          "ec2:DescribeAvailabilityZones"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "elasticfilesystem:CreateAccessPoint"
        ],
        Effect = "Allow"
        Resource = "*"
        Condition = {
          StringLike = {
            "aws:RequestTag/efs.csi.aws.com/cluster" = "true"
          }
        }
      },
      {
        Effect = "Allow",
        Action = "elasticfilesystem:DeleteAccessPoint",
        Resource = "*",
        Condition = {
          StringEquals = {
            "aws:ResourceTag/efs.csi.aws.com/cluster" = "true"
          }
        }
      }
    ]
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "efs" {
  policy_arn = aws_iam_policy.efs_csi.arn
  role       = aws_iam_role.efs.name
}

