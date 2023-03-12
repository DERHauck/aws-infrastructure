locals {
  external_dns_service_account_name = "external-dns-sa"
}

resource "helm_release" "external_dns" {
  chart      = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  name       = "dns"
  namespace  = local.system_namespace

  values = [
    templatefile("${path.module}/charts/external-dns.yaml", {
      service_account_name = local.external_dns_service_account_name
      iam_role_arn        = aws_iam_role.external_dns.arn
      eks_cluster_name = local.cluster_name
    })
  ]
  depends_on = [
    aws_eks_addon.coredns
  ]
}

resource "aws_iam_role" "external_dns" {
  name = "External_DNS_${local.cluster_name}"

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
            ("${local.eks_oidc_issuer}:sub") = "system:serviceaccount:${local.system_namespace}:${local.external_dns_service_account_name}"
          }
        }
      }
    ]
    Version = "2012-10-17"
  })
  tags = var.tags
}


resource "aws_iam_policy" "external_dns" {

  name   = "External_DNS_${local.cluster_name}"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow",
        "Action": [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets"
        ],
        "Resource": [
          "*"
        ]
      },
      {
        Action = [
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets"
        ]
        Effect   = "Allow"
        Resource = [for id, domain in var.hosted_zones : "arn:aws:route53:::hostedzone/${id}"]
      }
    ]
  })
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "external_dns" {
  policy_arn = aws_iam_policy.external_dns.arn
  role       = aws_iam_role.external_dns.name
}
