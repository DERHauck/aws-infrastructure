variable "name" {
  type = string
  description = "Project name"
}

variable "description" {
  type = string
  description = "Default project description"
  default = ""
}

variable "group_id" {
  type = number
  description = "Parent group id"
}

variable "visibility" {
  type = string
  default = "public"
  validation {
    condition = contains(["public", "internal", "private"], var.visibility)
    error_message = "Must be one of public, internal, private"
  }
}