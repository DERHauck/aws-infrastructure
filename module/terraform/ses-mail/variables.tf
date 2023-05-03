variable "service_name" {
  type = string
  description = "Name of the service that will be using ses"
}

variable "tags" {
  type = map(string)
  description = "Tags to add"
  default = {}
}