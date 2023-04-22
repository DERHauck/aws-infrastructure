resource "aws_iam_user" "nextcloud" {
  name = "nextcloud-s3"
}

resource "aws_iam_access_key" "nextcloud" {
  user = aws_iam_user.nextcloud.name
}

resource "aws_iam_policy" "nextcloud" {
  name = aws_iam_user.nextcloud.name
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

resource "aws_iam_user_policy_attachment" "nextcloud" {
  policy_arn = aws_iam_policy.nextcloud.arn
  user       = aws_iam_user.nextcloud.name
}
