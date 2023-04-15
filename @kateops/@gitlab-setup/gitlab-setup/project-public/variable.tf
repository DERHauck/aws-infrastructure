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

