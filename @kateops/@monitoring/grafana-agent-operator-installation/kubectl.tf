resource "kubectl_manifest" "cdrs" {
  for_each = local.crds
  yaml_body = each.value
}