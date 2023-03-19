resource "aws_iam_user" "vault" {
  name = "vault-user"
}

resource "aws_iam_access_key" "vault" {
  user = aws_iam_user.vault.name
}

resource "aws_iam_policy" "vault" {
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:DescribeLimits",
          "dynamodb:DescribeTimeToLive",
          "dynamodb:ListTagsOfResource",
          "dynamodb:DescribeReservedCapacityOfferings",
          "dynamodb:DescribeReservedCapacity",
          "dynamodb:ListTables",
          "dynamodb:BatchGetItem",
          "dynamodb:BatchWriteItem",
          "dynamodb:CreateTable",
          "dynamodb:DeleteItem",
          "dynamodb:GetItem",
          "dynamodb:GetRecords",
          "dynamodb:PutItem",
          "dynamodb:Query",
          "dynamodb:UpdateItem",
          "dynamodb:Scan",
          "dynamodb:DescribeTable"
        ]
        Effect   = "Allow"
        Resource = [
          aws_dynamodb_table.vault.arn
        ]
      }
    ]
  })
}

resource "aws_iam_role" "vault" {
  name = "IRSA_Vault"
  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = [
          "sts:AssumeRoleWithWebIdentity"
        ]
        Effect    = "Allow"
        Principal = {
          Federated = [
            "arn:aws:iam::${data.aws_caller_identity.this.account_id}:oidc-provider/${var.oidc_issuer}"
          ]
        }
        Condition = {
          StringEquals = {
            ("${var.oidc_issuer}:sub") = "system:serviceaccount:${var.namespace}:${local.sa_account_name}"
          }
        }
      }
    ]
    Version = "2012-10-17"
  })
}

data "aws_caller_identity" "this" {}

data "aws_iam_policy_document" "eks_tools_nodes_kms" {
  statement {
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey"
    ]
    resources = [
      aws_kms_key.vault_auto_unseal.arn
    ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "eks_tools_nodes_kms" {
  policy = data.aws_iam_policy_document.eks_tools_nodes_kms.json
  name   = "supporting-services-hc-vault-kms"
}

resource "aws_iam_role_policy_attachment" "eks_tools_nodes_kms" {
  policy_arn = aws_iam_policy.eks_tools_nodes_kms.arn
  role       = aws_iam_role.vault.name
}

resource "aws_iam_user_policy_attachment" "vault" {
  policy_arn = aws_iam_policy.vault.arn
  user       = aws_iam_user.vault.name
}