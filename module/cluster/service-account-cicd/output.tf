output "kubeconfig" {
  value = yamlencode(local.kube_config)
}