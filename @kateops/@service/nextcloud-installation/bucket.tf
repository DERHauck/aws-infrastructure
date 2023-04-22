data "aws_caller_identity" "this" {}

resource "aws_s3_bucket" "this" {
  bucket     = "${data.aws_caller_identity.this.account_id}-nextcloud-eu-central-1r-kateops"
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.bucket
  acl = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}
