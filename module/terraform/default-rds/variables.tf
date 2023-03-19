variable "database" {
  type = string
  description = "Default RDS endpoint"
}

variable "username" {
  type = string
  description = "Default RDS admin username"
}

variable "aws_access_key" {
  type = string
  description = "AWS terraform account access key"
}

variable "aws_secret_key" {
  type = string
  description = "AWS terraform account secret key"
}

variable "state_name" {
  type = string
  description = "AWS default state name"
}