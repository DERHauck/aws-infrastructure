variable "cluster_name" {
  type = string
  description = "EKS cluster name"
}

variable "vpc_id" {
  type = string
  description = "VPC id for EKS"
}

variable "subnet_id_map" {
  type = map(string)
  description = "List of subnet ids to use for EKS"
}

variable "tags" {
  type = object({})
  description = "Add additional tags to resources"
  default = {}
}

variable "hosted_zones" {
  type = map(string)
  description = "Add hosted zone for route53"
  default = {}
}

variable "cert_email" {
  description = "Mail to use for cert-manager"
  default = "service@netzwolke.com"
}