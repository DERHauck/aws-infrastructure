variable "aws_access_key" {
  type = string
  description = "AWS terraform account access key"
}

variable "aws_secret_key" {
  type = string
  description = "AWS terraform account secret key"
}

variable "vault_root_token" {
  type = string
  description = "Vault api root token"
}