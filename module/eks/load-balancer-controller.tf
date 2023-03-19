resource "helm_release" "aws_lbc" {
  repository = "https://aws.github.io/eks-charts"
  chart = "aws-load-balancer-controller"
  name  = "aws-lbc"

  namespace        = local.system_namespace
  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account.loadbalancer.metadata[0].name
  }

  set {
    name  = "clusterName"
    value = local.cluster_name
  }
  depends_on = [
    aws_eks_addon.coredns
  ]
}
resource "kubernetes_service_account" "loadbalancer" {
  metadata {
    name = "aws-loadbalancer-controller"
    namespace = local.system_namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.loadbalancer.arn
    }
  }
}

resource "kubernetes_secret_v1" "loadbalancer" {
  metadata {
    name = "aws-loadbalancer-controller-sa-token"
    namespace = local.system_namespace
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.loadbalancer.metadata[0].name
    }
  }
  type = "kubernetes.io/service-account-token"
}


resource "aws_iam_policy" "loadbalancer" {
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "iam:CreateServiceLinkedRole"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "iam:AWSServiceName" : "elasticloadbalancing.amazonaws.com"
            }
          }
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ec2:DescribeAccountAttributes",
            "ec2:DescribeAddresses",
            "ec2:DescribeAvailabilityZones",
            "ec2:DescribeInternetGateways",
            "ec2:DescribeVpcs",
            "ec2:DescribeVpcPeeringConnections",
            "ec2:DescribeSubnets",
            "ec2:DescribeSecurityGroups",
            "ec2:DescribeInstances",
            "ec2:DescribeNetworkInterfaces",
            "ec2:DescribeTags",
            "ec2:GetCoipPoolUsage",
            "ec2:DescribeCoipPools",
            "elasticloadbalancing:DescribeLoadBalancers",
            "elasticloadbalancing:DescribeLoadBalancerAttributes",
            "elasticloadbalancing:DescribeListeners",
            "elasticloadbalancing:DescribeListenerCertificates",
            "elasticloadbalancing:DescribeSSLPolicies",
            "elasticloadbalancing:DescribeRules",
            "elasticloadbalancing:DescribeTargetGroups",
            "elasticloadbalancing:DescribeTargetGroupAttributes",
            "elasticloadbalancing:DescribeTargetHealth",
            "elasticloadbalancing:DescribeTags"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "cognito-idp:DescribeUserPoolClient",
            "acm:ListCertificates",
            "acm:DescribeCertificate",
            "iam:ListServerCertificates",
            "iam:GetServerCertificate",
            "waf-regional:GetWebACL",
            "waf-regional:GetWebACLForResource",
            "waf-regional:AssociateWebACL",
            "waf-regional:DisassociateWebACL",
            "wafv2:GetWebACL",
            "wafv2:GetWebACLForResource",
            "wafv2:AssociateWebACL",
            "wafv2:DisassociateWebACL",
            "shield:GetSubscriptionState",
            "shield:DescribeProtection",
            "shield:CreateProtection",
            "shield:DeleteProtection"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ec2:AuthorizeSecurityGroupIngress",
            "ec2:RevokeSecurityGroupIngress"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ec2:CreateSecurityGroup"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ec2:CreateTags"
          ],
          "Resource" : "arn:aws:ec2:*:*:security-group/*",
          "Condition" : {
            "StringEquals" : {
              "ec2:CreateAction" : "CreateSecurityGroup"
            },
            "Null" : {
              "aws:RequestTag/elbv2.k8s.aws/cluster" : "false"
            }
          }
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ec2:CreateTags",
            "ec2:DeleteTags"
          ],
          "Resource" : "arn:aws:ec2:*:*:security-group/*",
          "Condition" : {
            "Null" : {
              "aws:RequestTag/elbv2.k8s.aws/cluster" : "true",
              "aws:ResourceTag/elbv2.k8s.aws/cluster" : "false"
            }
          }
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ec2:AuthorizeSecurityGroupIngress",
            "ec2:RevokeSecurityGroupIngress",
            "ec2:DeleteSecurityGroup"
          ],
          "Resource" : "*",
          "Condition" : {
            "Null" : {
              "aws:ResourceTag/elbv2.k8s.aws/cluster" : "false"
            }
          }
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "elasticloadbalancing:CreateLoadBalancer",
            "elasticloadbalancing:CreateTargetGroup"
          ],
          "Resource" : "*",
          "Condition" : {
            "Null" : {
              "aws:RequestTag/elbv2.k8s.aws/cluster" : "false"
            }
          }
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "elasticloadbalancing:CreateListener",
            "elasticloadbalancing:DeleteListener",
            "elasticloadbalancing:CreateRule",
            "elasticloadbalancing:DeleteRule"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "elasticloadbalancing:AddTags",
            "elasticloadbalancing:RemoveTags"
          ],
          "Resource" : [
            "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
            "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
            "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
          ],
          "Condition" : {
            "Null" : {
              "aws:RequestTag/elbv2.k8s.aws/cluster" : "true",
              "aws:ResourceTag/elbv2.k8s.aws/cluster" : "false"
            }
          }
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "elasticloadbalancing:AddTags",
            "elasticloadbalancing:RemoveTags"
          ],
          "Resource" : [
            "arn:aws:elasticloadbalancing:*:*:listener/net/*/*/*",
            "arn:aws:elasticloadbalancing:*:*:listener/app/*/*/*",
            "arn:aws:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
            "arn:aws:elasticloadbalancing:*:*:listener-rule/app/*/*/*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "elasticloadbalancing:ModifyLoadBalancerAttributes",
            "elasticloadbalancing:SetIpAddressType",
            "elasticloadbalancing:SetSecurityGroups",
            "elasticloadbalancing:SetSubnets",
            "elasticloadbalancing:DeleteLoadBalancer",
            "elasticloadbalancing:ModifyTargetGroup",
            "elasticloadbalancing:ModifyTargetGroupAttributes",
            "elasticloadbalancing:DeleteTargetGroup"
          ],
          "Resource" : "*",
          "Condition" : {
            "Null" : {
              "aws:ResourceTag/elbv2.k8s.aws/cluster" : "false"
            }
          }
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "elasticloadbalancing:RegisterTargets",
            "elasticloadbalancing:DeregisterTargets"
          ],
          "Resource" : "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "elasticloadbalancing:SetWebAcl",
            "elasticloadbalancing:ModifyListener",
            "elasticloadbalancing:AddListenerCertificates",
            "elasticloadbalancing:RemoveListenerCertificates",
            "elasticloadbalancing:ModifyRule"
          ],
          "Resource" : "*"
        }
      ]
    }

  )
}

resource "aws_iam_role" "loadbalancer" {
  name = "Loadbalancer_${local.cluster_name}"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "arn:aws:iam::${data.aws_caller_identity.this.account_id}:oidc-provider/${local.eks_oidc_issuer}"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          StringLike : {
            ("${local.eks_oidc_issuer}:sub") = "system:serviceaccount:${local.system_namespace}:*"
          }
          "StringEquals": {
            "${local.eks_oidc_issuer}:aud": "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "loadbalancer" {
  role       = aws_iam_role.loadbalancer.name
  policy_arn = aws_iam_policy.loadbalancer.arn
}

