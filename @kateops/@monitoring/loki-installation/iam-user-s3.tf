resource "aws_iam_user" "loki" {
  name = "loki-s3"
}

resource "aws_iam_access_key" "loki" {
  user = aws_iam_user.loki.name
}

resource "aws_iam_policy" "loki" {
  name = aws_iam_user.loki.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:ListBucketMultipartUploads",
        ]
        Effect = "Allow"
        Resource = [ aws_s3_bucket.this.arn ]
      },
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListMultiPartUploadParts",
          "s3:AbortMultipartUpload",
        ]
        Effect = "Allow"
        Resource = [ "${aws_s3_bucket.this.arn}/*" ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "loki" {
  policy_arn = aws_iam_policy.loki.arn
  user       = aws_iam_user.loki.name
}