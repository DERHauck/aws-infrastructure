resource "aws_iam_role" "gitlab" {
  name = "gitlab-access"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.cluster_issuer_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            ("${var.cluster_issuer}:aud") = "system:serviceaccount:gitlab:aws-access"
          }
        }
      }
    ]
  })
}

