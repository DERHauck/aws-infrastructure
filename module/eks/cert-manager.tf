locals {
  cert_manager_name = "cert-manager"
  cert_manager_sa_name = "${local.cert_manager_name}-sa"
}
resource "helm_release" "cert_manager" {
  repository = "https://charts.jetstack.io"
  name       = local.cert_manager_name
  chart      = "cert-manager"
  namespace  = local.system_namespace
  values = [
  templatefile("${path.module}/charts/cert-manager.yaml", {
    iam_role_arn = aws_iam_role.cert_manager.arn
    service_account_name = local.cert_manager_sa_name
    default_issuer_name = yamldecode(file("${path.module}/manifests/cluster-issuer.cert-manager.yaml"))["metadata"]["name"]
    default_issuer_kind = yamldecode(file("${path.module}/manifests/cluster-issuer.cert-manager.yaml"))["kind"]
  })]
  depends_on = [
    aws_eks_addon.coredns
  ]
}

resource "kubectl_manifest" "cert_manager" {
  for_each = { for v in fileset("${path.module}/manifests", "*.cert-manager.yaml"): "${path.module}/manifests/${v}" => "${path.module}/manifests/${v}" }
  yaml_body = templatefile(each.value, {
    hosted_zones = var.hosted_zones
    email = var.cert_email
    secret_name = "${local.cluster_name}-cert-manager-tls"
  })

  depends_on = [
    helm_release.karpenter
  ]
}

resource "aws_iam_role" "cert_manager" {
  name   = "Cert_Manager_${local.cluster_name}"
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
            ("${local.eks_oidc_issuer}:sub") = "system:serviceaccount:${local.system_namespace}:${local.cert_manager_sa_name}"
          }
        }
      }
    ]
    Version = "2012-10-17"
  })

  tags = local.tags
}

resource "aws_iam_policy" "cert_manager" {

  name   = "Cert_Manager_${local.cluster_name}"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action = "route53:getChange"
        Effect = "Allow"
        Resource = "arn:aws:route53:::change/*"
      },
      {
        Action = [
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets"
        ]
        Effect   = "Allow"
        Resource = [ for id, domain in var.hosted_zones: "arn:aws:route53:::hostedzone/${id}" ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cert_manager" {
  policy_arn = aws_iam_policy.cert_manager.arn
  role       = aws_iam_role.cert_manager.name
}

