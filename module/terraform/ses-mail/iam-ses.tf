resource "aws_iam_user" "this" {
  name = "${var.service_name}-ses-user"
  tags = var.tags
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

resource "aws_iam_policy" "this" {
  name   = "${var.service_name}_ses_user"
  policy = jsonencode({
    Statement = [
      {
        Action = [
          "ses:SendRawEmail"
        ]
        Resource = ["*"]
        Effect = "Allow"
      }

    ]
    Version = "2012-10-17"
  })
  tags = var.tags
}


resource "aws_iam_user_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  user       = aws_iam_user.this.name
}