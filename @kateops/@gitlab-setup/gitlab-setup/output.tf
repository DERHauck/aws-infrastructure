output "image_pull_secret" {
  value = kubernetes_secret.runner.metadata[0].name
}