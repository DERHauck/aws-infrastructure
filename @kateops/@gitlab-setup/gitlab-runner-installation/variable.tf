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

variable "image_pull_secret" {
  type = string
  description = "Runner docker image pull secret"
}

variable "cpu_limit" {
  type = string
  description = "in milli (m)"
  default = "500m"
  nullable = false
}

variable "memory_limit" {
  type = string
  description = "in byte (Mi/Gi)"
  default = "800Mi"
  nullable = false
}

variable "service_cpu_limit" {
  type = string
  description = "in milli (m)"
  default = "500m"
  nullable = false
}

variable "service_memory_limit" {
  type = string
  description = "in byte (Mi/Gi)"
  default = "800Mi"
  nullable = false
}

variable "helper_cpu_limit" {
  type = string
  description = "in milli (m)"
  default = "100m"
  nullable = false
}

variable "helper_memory_limit" {
  type = string
  description = "in byte (Mi/Gi)"
  default = "300Mi"
  nullable = false
}

variable "anti_affinity" {
  type = object({
    topology_key = string
    key = string
    operator = string
    values = list(string)
  })
  description = "anti affinity for runner pods"
  default = null
  nullable = true
}

variable "provisioner_name" {
  type = string
  default = "default"
  nullable = false
  description = "karpenter provisioner to use for type/gitlab-runner"
}