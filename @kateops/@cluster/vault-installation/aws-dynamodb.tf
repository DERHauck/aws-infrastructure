resource "aws_kms_key" "vault_auto_unseal" {
  description = "Vault Auto-Unseal Key"
}

resource "aws_dynamodb_table" "vault" {
  name = "vault-table"
  hash_key = "Path"
  range_key = "Key"
  read_capacity = 10
  write_capacity = 10
  attribute {
    name = "Path"
    type = "S"
  }

  attribute {
    name = "Key"
    type = "S"
  }
}