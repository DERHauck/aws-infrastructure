module "ses" {
  source = "./../../../module/terraform/ses-mail"
  service_name = "grafana"
}