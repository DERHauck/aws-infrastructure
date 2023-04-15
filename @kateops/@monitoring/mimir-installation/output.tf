output "mimir_service" {
  value =  "http://mimir-distributor.${var.namespace}.svc.cluster.local:8080/api/v1/push"
}