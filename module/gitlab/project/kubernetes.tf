resource "kubernetes_secret" "argo" {
  metadata {
    name = "repo-${replace(gitlab_project.this.path_with_namespace, "/", "-")}"
    namespace = "argo"
    labels = {
      "argocd.argoproj.io/secret-type": "repository"
    }
  }
  data = {
    type = "git"
    url = gitlab_project.this.http_url_to_repo
  }
}

resource "kubectl_manifest" "argo_application" {
  yaml_body = templatefile("${local.argo_manifests_path}/application.yaml", {
    namespace = data.gitlab_group.this.path
    repo_url = gitlab_project.this.http_url_to_repo
    application_name = gitlab_project.this.path
  })
}