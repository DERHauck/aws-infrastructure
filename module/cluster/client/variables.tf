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

variable "visibility" {
  type = string
  default = "internal"
  validation {
    condition = contains(["public", "internal", "private"], var.visibility)
    error_message = "Must be one of public, internal, private"
  }
}