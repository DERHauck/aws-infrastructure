variable "namespace" {
  type = string
  description = "Kubernetes Namespace"
}

variable "concurrency" {
  type = number
  description = "Runner max concurrency"
}

variable "access_key" {
  type = string
  description = "Runner IAM Api Access Key"
}

variable "secret_key" {
  type = string
  description = "Runner IAM Api Secret Key"
}

variable "region" {
  type = string
  default = "eu-central-1"
  description = "Scaleway region default (fr-par)"
}

variable "s3_cache_bucket_name" {
  type = string
  description = "S3 gitlab cache bucket name"
}

variable "pressure" {
  type = string
  description = "Resource pressure size runner needs"
}

variable "s3_default_host" {
  type = string
  description = "Default host for s3 bucket eg. s3.fr-pa.scw.cloud"
}

variable "registration_token" {
  type = string
  description = "Gitlab instance runner registration token"
}