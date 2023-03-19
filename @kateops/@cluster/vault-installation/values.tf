locals {
  vars = {
    vault_auto_unseal_key_id = aws_kms_key.vault_auto_unseal.id
    dynamodb_table_name = aws_dynamodb_table.vault.name
    dynamodb_access_key = aws_iam_access_key.vault.id
    dynamodb_secret_key = aws_iam_access_key.vault.secret
    sa_account_name = local.sa_account_name
    irsa_arn = aws_iam_role.vault.arn
  }
  templates = [for v in fileset("${path.module}/values", "*.yaml") : templatefile("${path.module}/values/${v}", local.vars)]
}