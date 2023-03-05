data "aws_subnet" "private" {
  for_each = toset(var.subnet_id_list)
  id = each.value
}