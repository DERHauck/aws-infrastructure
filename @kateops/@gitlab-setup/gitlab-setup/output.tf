output "image_pull_secret" {
  value = kubernetes_secret.runner["gitlab"].metadata[0].name
}