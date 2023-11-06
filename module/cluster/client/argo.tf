locals {
  argo_manifests_path = "${path.module}/argo-manifests"
}


resource "kubectl_manifest" "argo_project" {
  yaml_body = templatefile("${local.argo_manifests_path}/project.yaml", {
    namespace     = kubernetes_namespace.this.metadata[0].name
    name = local.sanitized_name
  })
}