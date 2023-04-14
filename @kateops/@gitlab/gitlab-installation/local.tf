locals {
  buckets_tmp = [
  for k, s in fileset(local.bucket_dir, "*") : yamldecode(file("${local.bucket_dir}/${s}"))["buckets"]
  ]
  bucket_dir         = "${path.module}/data/bucket"
  s3_default_host    = "s3.${var.region}.scw.cloud"
  email_display_name = "Gitlab Service"
  email_from_address = "gitlab@${var.gitlab_host_domain}"
  buckets = length(local.buckets_tmp) > 0 ? { for e in flatten(local.buckets_tmp) : e["name"] => e} : null
}