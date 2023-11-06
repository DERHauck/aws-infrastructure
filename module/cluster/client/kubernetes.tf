resource "kubernetes_namespace" "this" {
  metadata {
    name = local.sanitized_name
  }
}

resource "kubernetes_secret" "gitlab_secret" {
  metadata {
    name = "runner-registry-ro"
    namespace = kubernetes_namespace.this.metadata[0].name
  }
  type = "kubernetes.io/dockerconfigjson"
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "hub.kateops.com" = {
          auth = base64encode("${data.gitlab_user.group_user.name}:${gitlab_group_access_token.this.token}")
        }
        "gitlab.kateops.com" = {
          auth = base64encode("${data.gitlab_user.group_user.name}:${gitlab_group_access_token.this.token}")
        }
      }
    })
  }
}
data "gitlab_user" "group_user" {
  user_id = gitlab_group_access_token.this.user_id
}

module "service-account-cicd" {
  source = "./../service-account-cicd"
  namespace = kubernetes_namespace.this.metadata[0].name
  cluster_certificate_authority_data = var.cluster_certificate_authority_data
  cluster_endpoint = var.cluster_endpoint
  cluster_name = var.cluster_name
}


resource "kubernetes_secret" "argo" {
  metadata {
    name = "credentials-${local.sanitized_name}"
    namespace = "argo"
    labels = {
      "argocd.argoproj.io/secret-type": "repo-creds"
    }
  }
  data = {
    type = "git"
    url = "https://gitlab.kateops.com/${gitlab_group.this.full_path}"
    password = gitlab_group_access_token.argo.token
    username = gitlab_group_access_token.argo.name
  }
}

data "gitlab_group" "this" {
  group_id = gitlab_group.this.id
}