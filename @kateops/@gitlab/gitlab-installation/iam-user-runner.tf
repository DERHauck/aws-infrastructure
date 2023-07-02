resource "aws_iam_user" "runner" {
  name = "gitlab-runner-s3"
}

resource "aws_iam_access_key" "runner" {
  user = aws_iam_user.runner.name
}

resource "aws_iam_policy" "runner" {
  name = aws_iam_user.runner.name
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
        Resource = [ for buckets in aws_s3_bucket.this : buckets.arn ]
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
        Resource = [ for buckets in aws_s3_bucket.this : "${buckets.arn}/*" ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "runner" {
  policy_arn = aws_iam_policy.runner.arn
  user       = aws_iam_user.runner.name
}