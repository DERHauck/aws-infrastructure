variable "name" {
  type = string
  description = "Name of the Client"
}

variable "cluster_certificate_authority_data" {
  type = string
  description = "Cluster CA"
}

variable "cluster_endpoint" {
  type = string
  description = "Cluster Control Plane Endpoint"
}

variable "cluster_name" {
  type = string
  description = "Cluster Name"
}