resource "aws_iam_user" "dev_kateops" {
  name = "cert-manager-dev"
}

resource "aws_iam_access_key" "dev_kateops" {
  user = aws_iam_user.dev_kateops.name
}


resource "aws_iam_policy" "dev_kateops" {
  name = "${aws_iam_user.dev_kateops.name}-access"
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
        ]
        Effect   = "Allow"
        Resource = [ "arn:aws:route53:::hostedzone/${data.aws_route53_zone.kateops.id}" ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "dev_kateops" {
  user       = aws_iam_user.dev_kateops.name
  policy_arn = aws_iam_policy.dev_kateops.arn
}

data "aws_route53_zone" "kateops" {
  name = "kateops.com"
}

resource "vault_generic_secret" "dev_kateops" {
  path      = "kateops/cert-manager/development"
  data_json = jsonencode({
    access_key = aws_iam_access_key.dev_kateops.id
    secret_key = aws_iam_access_key.dev_kateops.secret
  })
}