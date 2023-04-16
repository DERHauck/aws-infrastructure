locals {
  dashboard_files = fileset("${path.module}/dashboard", "**/*.json")
  folder_names = distinct([for file in local.dashboard_files : dirname(file)])
}

resource "grafana_folder" "subfolders" {
  for_each = toset(local.folder_names)

  title = each.key
  uid = "tf-${lower(each.key)}"
}


data "local_file" "dashboard_files" {
  for_each = local.dashboard_files
  filename = "${path.module}/dashboard/${each.key}"
}


resource "grafana_dashboard" "dashboards" {
  for_each = data.local_file.dashboard_files

  config_json = each.value.content
  folder      = grafana_folder.subfolders[dirname(each.key)].id
  overwrite   = true

  depends_on = [
    grafana_folder.subfolders
  ]
}
