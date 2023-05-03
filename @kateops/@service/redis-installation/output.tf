output "password" {
  value = random_password.password.result
  sensitive = true
}

output "port" {
  value = 6379
}

output "host-master" {
  value = "redis-master.${var.namespace}.svc.cluster.local"
}

output "host-read" {
  value = "redis-headless.${var.namespace}.svc.cluster.local"
}