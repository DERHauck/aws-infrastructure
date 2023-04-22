locals {
  bucket_name = "-${var.region}-kateops"
}

data "aws_caller_identity" "this" {}

resource "aws_s3_bucket" "this" {
  for_each = local.buckets
  bucket     = "${data.aws_caller_identity.this.account_id}-${each.value["name"]}-${var.region}-kateops"
  tags     = lookup(each.value, "tags")
}

resource "aws_s3_bucket_acl" "this" {
  for_each = local.buckets
  bucket = aws_s3_bucket.this[each.key].id
  acl = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  for_each = local.buckets
  bucket = aws_s3_bucket.this[each.key].id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}
