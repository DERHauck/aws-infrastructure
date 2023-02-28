variable "cluster_name" {
  type = string
  description = "EKS cluster name"
}

variable "vpc_id" {
  type = string
  description = "VPC id for EKS"
}

variable "subnet_id_list" {
  type = list(string)
  description = "List of subnet ids to use for EKS"
}