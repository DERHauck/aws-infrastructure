resource "aws_iam_user" "mimir" {
  name = "mimir-s3"
}

resource "aws_iam_access_key" "mimir" {
  user = aws_iam_user.mimir.name
}

resource "aws_iam_policy" "mimir" {
  name = aws_iam_user.mimir.name
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

resource "aws_iam_user_policy_attachment" "mimir" {
  policy_arn = aws_iam_policy.mimir.arn
  user       = aws_iam_user.mimir.name
}

#resource "aws_iam_role" "mimir" {
#  assume_role_policy = ""
#}
#
#resource "aws_iam_policy_attachment" "mimir" {
#  name       = aws_iam_role.mimir.name
#  policy_arn = aws_iam_policy.mimir.arn
#}