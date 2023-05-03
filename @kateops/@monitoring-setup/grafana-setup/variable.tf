variable "tenant_id" {
  type = string
  description = "The id of the tenant for specific datasources like loki"
}

variable "redis_password" {
  type = string
  description = "Redis Password"
  default = ""
}