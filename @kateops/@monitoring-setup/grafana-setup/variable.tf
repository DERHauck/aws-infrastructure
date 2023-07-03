variable "tenant_id" {
  type = string
  description = "The id of the tenant for specific datasources like loki"
}

variable "redis_password" {
  type = string
  description = "Redis Password"
  default = ""
}

variable "redis_url" {
  type = string
  description = "Redis connection URL e.g. redis://svc:port"
}