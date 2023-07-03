resource "grafana_data_source" "loki" {
  name = "Loki"
  type = "loki"
  url = "http://loki-loki-distributed-query-frontend:3100"
  uid = "loki-default"
  http_headers = {
    "X-Scope-OrgID": var.tenant_id
  }
}

resource "grafana_data_source" "mimir" {
  name = "Mimir"
  type = "prometheus"
  url = "http://mimir-query-frontend.monitoring.svc.cluster.local:8080/prometheus"
  http_headers = {
    X-Scope-OrgID = var.tenant_id
  }
  uid = "mimir-default"
  is_default = true
}
#
resource "grafana_data_source" "redis" {
  name = "Redis"
  type = "redis-datasource"
  url = var.redis_url
  uid = "redis-default"
  secure_json_data_encoded = jsonencode({
    password = var.redis_password
  })
}

resource "grafana_data_source_permission" "redis" {
  datasource_id = grafana_data_source.redis.id
  permissions {

    permission = ""
  }
}

#resource "grafana_data_source" "prometheus" {
#  name = "Prometheus"
#  type = "prometheus"
#  url = "http://prometheus-kube-prometheus-prometheus.monitoring.svc.cluster.local:9090"
#  uid = "prometheus-default"
#  is_default = true
#}
