#resource "vault_generic_secret" "dashboard_secret" {
#  path      = "admin/dashboard/kateops"
#  data_json = jsonencode({
#    token: kubernetes_service_account.cluster-admin.secret
#  })
#}