data "aws_subnet" "private" {
  for_each = var.subnet_id_map
  id = each.value
}

data "aws_caller_identity" "this" {}